# Script for mapping statistically-significant unitigs to their genes of origin

# Pre-requisites
# pyseer --version: 1.3.11
# bwa --version: 0.7.17
# summarise_annotations.py script obtained from Pyseer github: https://github.com/mgalardini/pyseer/blob/master/scripts/summarise_annotations.py

###############################################################################################
# Unitig mapping to genes of origin

fasta_dir="/assemblies"
gff_dir="/prokka_gffs"
output_file="references.txt"

for fasta_file in "$fasta_dir"/*.fasta; do
    fasta_basename=$(basename "$fasta_file")
    gff_file="$gff_dir/${fasta_basename%.fa}.gff"
    echo "$fasta_file   $gff_file   draft" >> "$output_file"
done

annotate_hits_pyseer unitigs_pyseer_lmm_filtered_padj.tsv references.txt unitig1370_annotation.txt

python summarise_annotations.py unitig1370_annotation.txt >> unitig1370_annotation_results.txt