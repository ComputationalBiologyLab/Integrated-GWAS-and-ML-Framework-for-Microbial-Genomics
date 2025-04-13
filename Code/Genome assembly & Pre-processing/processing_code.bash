# Script for genome annotation, pangenome construction & multi-locus sequence typing

# Pre-requisites
# prokka --version: 1.14.6
# roary --version: 3.12.0
# mlst --version: 2.16.1


###############################################################################################
# Prokka assembly annotation

for F in *.fasta; do
   N=${F%%_polished5.fasta}
   prokka --cpus 3 --locustag $N --outdir ./prokka_output/$N --prefix $N $F
   cp ./prokka_output/$N/$N.gff ./prokka_gffs/
done

##############################################################################################
# Roary pangenome construction

roary -f ./roary_all/ -p 4 -e -n -v --mafft ./prokka_gffs/*.gff

##############################################################################################
# Multi-locus sequence typing (MLST) of the isolates

for f1 in ./*.fasta; do
    mlst --nopath --csv $f1 >> mlst_results.csv
done