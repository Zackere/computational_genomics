#!/bin/bash
set -v
cd $( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
files=()

# Lab 1
files+=( http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa )
files+=( http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa.sa )
files+=( http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa.pac )
files+=( http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa.fai )
files+=( http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa.bwt )
files+=( http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa.ann )
files+=( http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa.amb )
files+=( http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa.alt )
files+=( http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.dict )
files+=( http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla-extra.fa )
files+=( http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/other_mapping_resources/ALL_20141222.dbSNP142_human_GRCh38.snps.vcf.gz )
files+=( http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/HG00599/sequence_read/SRR590764_2.filt.fastq.gz )
files+=( http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/HG00599/sequence_read/SRR590764_1.filt.fastq.gz )
files+=( ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/other_mapping_resources/ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf.gz )
files+=( ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/other_mapping_resources/Mills_and_1000G_gold_standard.indels.b38.primary_assembly.vcf.gz )
files+=( ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/other_mapping_resources/ALL_20141222.dbSNP142_human_GRCh38.snps.vcf.gz )

# Lab 3
files+=( https://pages.mini.pw.edu.pl/~chilinskim/GO_files/SRR_SNPs.vcf )
files+=( https://pages.mini.pw.edu.pl/~chilinskim/GO_files/hic_matrices.zip )
files+=( https://pages.mini.pw.edu.pl/~chilinskim/GO_files/IntermediateFiles/SRR.sam )
files+=( https://pages.mini.pw.edu.pl/~chilinskim/GO_files/IntermediateFiles/SRR_final_sorted.bam )
files+=( https://pages.mini.pw.edu.pl/~chilinskim/GO_files/IntermediateFiles/SRR_sorted.intervals )
files+=( https://pages.mini.pw.edu.pl/~chilinskim/GO_files/IntermediateFiles/SRR_sorted_p3.bam )
files+=( https://pages.mini.pw.edu.pl/~chilinskim/GO_files/IntermediateFiles/SRR_sorted_recal_data.table )
files+=( https://pages.mini.pw.edu.pl/~chilinskim/GO_files/eqtl_anal/ALL.wgs.mergedSV.v8.20130502.svs.genotypes.vcf )
files+=( https://pages.mini.pw.edu.pl/~chilinskim/GO_files/eqtl_anal/GD462.GeneQuantRPKM.50FN.samplename.resk10.txt )

mkdir -p data
cd data

wget --no-clobber https://spages.mini.pw.edu.pl/~replinw/computational_genomics.7z && 7z e computational_genomics.7z

for file in ${files[@]}
do
	wget --no-clobber "$file"
done
