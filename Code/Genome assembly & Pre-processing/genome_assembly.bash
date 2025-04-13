# Script for performing the steps of the genome assembly pipeline

# Pre-requisites
# fastp --version: 0.23.2
# spades --version: 3.15.5
# pilon --version: 1.24
# bwa --version: 0.7.17
# samtools --version: 1.6
# busco --version: 5.5.0
# quast --version: 5.2.0
# polishing_script.sh file

#############################################################################################
# Fastp trimming

for f1 in *_R1_001.fastq.gz; do   
    f2=${f1%%_R1_001.fastq.gz}"_R2_001.fastq.gz"  
   
    fastp --detect_adapter_for_pe -c -5 -3 \
          -i "$f1" -I "$f2" \
          -o "trimmed-$f1" -O "trimmed-$f2"  
done

#############################################################################################
# SPAdes de novo assembly

for f1 in *_R1_001.fastq.gz; do
  f2=${f1%%_R1_001.fastq.gz}"_R2_001.fastq.gz"
  output_directory="${f1}.spades_assembly"
 
  spades.py -1 ${f1} -2 ${f2} --careful -o $output_directory

done

#############################################################################################
# Pilon polishing

for dir in ./*; do
        cd $dir


        read1=$(find . -type f -name 'trimmed*R1*.fastq.gz')


        read2=$(find . -type f -name 'trimmed*R2*.fastq.gz')


        reference=$(find . -type f -name '*scaffolds.fasta')


        bash polishing_script.sh $reference $read1 $read2 


        cd ..
done

#############################################################################################
# BUSCO assessment

busco -i ./polished_genomes -l bacteria_odb10 -o ./busco_output -m genome

#############################################################################################
# QUAST assessment

quast *.fasta