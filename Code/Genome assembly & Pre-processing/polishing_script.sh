#!/bin/bash

reference=$1
read1=$2
read2=$3

echo "Round1"
bwa index $reference
bwa mem $reference $read1 $read2 | samtools view - -Sb | samtools sort -o mapping1.sorted.bam
samtools index mapping1.sorted.bam
pilon --genome $reference --fix all --changes --frags mapping1.sorted.bam --threads 8 --output pilon_stage1 | tee stage1.pilon

echo "Round2"
bwa index pilon_stage1.fasta
bwa mem  pilon_stage1.fasta $read1 $read2| samtools view - -Sb | samtools sort -o mapping2.sorted.bam
samtools index mapping2.sorted.bam
pilon --genome pilon_stage1.fasta --fix all --changes --frags mapping2.sorted.bam --output pilon_stage2 | tee stage2.pilon

echo "Round3"
bwa index pilon_stage2.fasta
bwa mem pilon_stage2.fasta $read1 $read2| samtools view - -Sb | samtools sort -o mapping3.sorted.bam
samtools index mapping3.sorted.bam
pilon --genome pilon_stage2.fasta --fix all --changes --frags mapping3.sorted.bam  --output pilon_stage3 | tee stage3.pilon

echo "Round4"
bwa index pilon_stage3.fasta
bwa mem pilon_stage3.fasta $read1 $read2| samtools view - -Sb | samtools sort -o mapping4.sorted.bam
samtools index mapping4.sorted.bam
pilon --genome pilon_stage3.fasta --fix all --changes --frags mapping4.sorted.bam --output pilon_stage4 | tee stage4.pilon

echo "Round5"
bwa index pilon_stage4.fasta
bwa mem pilon_stage4.fasta $read1 $read2| samtools view - -Sb | samtools sort -o mapping5.sorted.bam
samtools index mapping5.sorted.bam
pilon --genome pilon_stage4.fasta --fix all --changes --frags mapping5.sorted.bam --output pilon_stage5 | tee stage5.pilon