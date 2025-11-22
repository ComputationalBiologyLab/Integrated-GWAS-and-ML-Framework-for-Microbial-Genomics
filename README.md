# Introduction
Computational framework that integrates a genome-wide association study (GWAS) module with a learning-based module for the genetic characterization of biofilm formation in Egyptian, clinical _Stapylococcus aureus_ isolates.

**Study Name**: "_Integrated Genome-Wide Association Study and Machine Learning Approach For Characterization of Biofilm Formation Determinants in Staphylococcus aureus_"

**Code By**: Lydia R. Sidarous

**Revised By**: Dr. Eman Badr
# Code Modules
<img width="4378" height="2482" alt="Image" src="https://github.com/user-attachments/assets/31131e3c-e4bd-49ef-8a4b-dc9b7a13aa5b" />

## Genome assembly & Pre-processing
1. Genome assembly pipeline (_genome_assembly_code.bash_ & _polishing_script.sh_)
    - Trimming
    - _De novo_ genome assembly
    - Genome polishing
    - Quality assessment
2. Additional processing (_processing_code.bash_)
    - Genome annotation
    - Pangenome construction
    - Multi-locus sequence typing

## Genome-Wide Association Study (GWAS) module
1. Unitig-GWAS pipeline (_GWAS_code.bash_)
    - Extraction of unitigs from genome assemblies
    - Phylogeny construction for Pyseer similarity matrix (using _core_gene_alignment.aln_ file from pangenome construction)
    - Pyseer unitig-GWAS using linear mixed models (LMM)

2. GWAS post-processing (_BH_pvalue_adjustment_code.ipynb_ & _GWAS_post_processing_code.bash_)
    - Filtering of statistically-significant unitigs based on Benjamini-Hochberg adjusted lrt p-value ≤ 0.05
    - Mapping of statistically-significant unitigs to genes of origin (using assembly fasta files & annotation gff files)

## Machine Learning (ML) module
Three classifiers were constructed: 
1. Support Vector Machines (_SVM_binary_and_multiclass.ipynb_) 
2. Logistic Regression (_LogReg_binary_and_multiclass.ipynb_)
3. Extreme Gradient Boosting Trees (_XGBoost_binary_and_multiclass.ipynb_) 

These were trained on the gene presence/absence matrix (_gene_presence_absence.Rtab_) produced during pangenome construction in _processing_code.bash_. The same workflow was implemented to construct the three classifiers - in binary & multiclass classification:

- SMOTE oversampling of minority class(es) to the majority class
- Recursive Feature Elimination for feature selection
- Hyperparameter tuning using Grid Search
- Evaluation using various performance metrics (accuracy, F1-score, ROC-AUC score)
# Usage
## Installation & Pre-requisites
1. Linux packages
    - All pre-requisite packages and their corresponding versions are specified within the bash code files.
    - All Linux packages were installed using conda.
2. Python packages
    - Python packages are all specified in the import statements of Python notebook files.
    - All Python packages were installed using pip.

## Input files
1. Raw reads
- [PRJNA648411](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA648411/)
- [PRJNA964454](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA964454/)
- [PRJNA1135495](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA1135495/)
- [PRJNA1246983](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA1246983/)

2. Biofilm formation phenotypes
- For GWAS: _pyseer_pheno_ext.tsv_
- For Binary ML: _biofilm_pheno_binary.tsv_
- For Multiclass ML: _biofilm_pheno_multi.tsv_

3. Gene presence/absence matrix (_gene_presence_absence.Rtab_) for ML classifier construction
