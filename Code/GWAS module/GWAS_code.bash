# Script for running Pyseer linear mixed models (LMM) GWAS on unitigs

# Pre-requisites
# unitig-caller --version: 1.3.0
# iqtree --version: 2.2.6
# pyseer --version: 1.3.11
# phylogeny_distance.py script obtained from Pyseer github: https://github.com/mgalardini/pyseer/blob/master/scripts/phylogeny_distance.py

#############################################################################################
# Extracting unitigs from assemblies using unitig-caller

ls -d -1 $PWD/*.fasta > refs_extreme.txt

unitig-caller --call --refs refs_extreme.txt --pyseer --rtab --out extreme_unitigs_pyseer --threads 16

gzip -k extreme_unitigs_pyseer.pyseer

###############################################################################################
# Preparing similarity matrix for Pyseer LMM GWAS

iqtree2 -s core_gene_alignment.aln -B 1000

python phylogeny_distance.py --lmm core_gene_alignment.aln.treefile > phylogeny_similarity_ext.tsv

###############################################################################################
# Pyseer LMM GWAS on unitigs

pyseer --lmm \
       --phenotypes pyseer_pheno_ext.tsv \
       --kmers extreme_unitigs_pyseer.pyseer.gz \
       --similarity phylogeny_similarity_ext.tsv \
       --output-patterns unitig_patterns_ext.txt \
       > unitig_pyseer_lmm_output.tsv