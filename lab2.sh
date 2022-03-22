#!/bin/bash -v

cd $( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
mkdir -p lab2
cd lab2

if [[ ! -f ../data/delly.bcf ]]
then
    ( cd ../data && delly call -o delly.bcf -g GRCh38_full_analysis_set_plus_decoy_hla.fa SRR_final_sorted.bam )
fi
if [[ ! -f ../data/delly.vcf ]]
then
    ( cd ../data && bcftools view delly.bcf > delly.vcf )
fi
if [[ ! -f ../data/SRR_SNPs.bcf ]]
then
    ( cd ../data && bcftools mpileup -Ou -f GRCh38_full_analysis_set_plus_decoy_hla.fa SRR_final_sorted.bam | bcftools call -mv -Ob -o SRR_SNPs.bcf )
fi
if [[ ! -f ../data/SRR_SNPs.vcf ]]
then
    ( cd ../data && bcftools view -i '%QUAL>=20' SRR_SNPs.bcf > SRR_SNPs.vcf )
fi