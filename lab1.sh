cd $( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
mkdir -p lab1
cd lab1

if [[ ! -d bwa-0.7.17 ]]
then
    wget --no-clobber https://netcologne.dl.sourceforge.net/project/bio-bwa/bwa-0.7.17.tar.bz2
    tar -xjf bwa-0.7.17.tar.bz2
    ( cd bwa-0.7.17 && make )
fi
if [[ ! -f hs38DH.fa.alt ]]
then
    wget --no-clobber https://netcologne.dl.sourceforge.net/project/bio-bwa/bwakit/bwakit-0.7.15_x64-linux.tar.bz2
    tar -xjf bwakit-0.7.15_x64-linux.tar.bz2
    cp bwa.kit/resource-GRCh38/hs38DH.fa.alt .
fi
if [[ ! -d biobambam2 ]]
then
    wget --no-clobber https://github.com/gt1/biobambam2/releases/download/2.0.87-release-20180301132713/biobambam2-2.0.87-release-20180301132713-x86_64-etch-linux-gnu.tar.gz
    tar -xzf biobambam2-2.0.87-release-20180301132713-x86_64-etch-linux-gnu.tar.gz
fi
if [[ ! -d samtools-1.11 ]]
then
    wget --no-clobber https://github.com/samtools/samtools/releases/download/1.11/samtools-1.11.tar.bz2
    tar -xjf samtools-1.11.tar.bz2
    ( cd samtools-1.11 && make )
fi
wget --no-clobber https://pages.mini.pw.edu.pl/~chilinskim/GO_files/GenomeAnalysisTK.jar
# Produces
# GRCh38_full_analysis_set_plus_decoy_hla.fa.amb
# GRCh38_full_analysis_set_plus_decoy_hla.fa.ann
# GRCh38_full_analysis_set_plus_decoy_hla.fa.bwt
# GRCh38_full_analysis_set_plus_decoy_hla.fa.pac
# GRCh38_full_analysis_set_plus_decoy_hla.fa.sa
if [[ ! -f ../data/GRCh38_full_analysis_set_plus_decoy_hla.fa.amb ]]
then
    ./bwa-0.7.17/bwa index ../data/GRCh38_full_analysis_set_plus_decoy_hla.fa
fi
if [[ ! -f ../data/SRR.sam ]]
then
    ./bwa-0.7.17/bwa mem -t 1 -B 4 -O 6 -E 1 -M -R "@RG\tID:SRR\tLB:LIB_1\tSM:SAMPLE_1\tPL:ILLUMINA" ../data/GRCh38_full_analysis_set_plus_decoy_hla.fa ../data/SRR590764_1.filt.fastq ../data/SRR590764_2.filt.fastq > ../data/SRR.sam
fi
if [[ ! -f ../data/ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf ]]
then
    ( cd ../data && gunzip -k ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf.gz )
    sed -i 's/=dbSNP ssID/="dbSNP ssID/g' ../data/ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf
    sed -i 's/ID=POS=POS-1/ID=POSPOS1/g' ../data/ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf
    sed -i 's/Primary Assembly/PrimaryAssembly/g' ../data/ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf
    sed -i 's/First Pass/FirstPass/g' ../data/ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf
    sed -i 's/Second Pass/SecondPass/g' ../data/ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf
fi
if [[ ! -f ../data/SRR_sorted.intervals ]]
then
    ( cd ../data/ && java -Xmx4g -jar ../lab1/GenomeAnalysisTK.jar -T RealignerTargetCreator -R GRCh38_full_analysis_set_plus_decoy_hla.fa -known ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf -known Mills_and_1000G_gold_standard.indels.b38.primary_assembly.vcf -I SRR_sorted.bam -o SRR_sorted.intervals )
fi
if [[ ! -f ../data/Mills_and_1000G_gold_standard.indels.b38.primary_assembly.vcf ]]
then
    ( cd ../data && gunzip -k Mills_and_1000G_gold_standard.indels.b38.primary_assembly.vcf.gz )
fi
if [[ ! -f ALL_20141222.dbSNP142_human_GRCh38.snps.vcf ]]
then
    ( cd ../data && gunzip -k ALL_20141222.dbSNP142_human_GRCh38.snps.vcf.gz )
fi
