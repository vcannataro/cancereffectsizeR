prev_dir = setwd(system.file("tests/test_data/", package = "cancereffectsizeR"))

# read in the MAF, assign three random groups, and annotate

# To-Do: Add a CDKN2A mutation to MAF, at some point. list("sample-9999", 9, 21971186, 'G', 'A')
maf = fread("luad.hg19.maf.txt")
setnames(maf, 'sample_id', 'Unique_Patient_Identifier')
maf = preload_maf(maf, refset = 'ces.refset.hg19')
set.seed(879)
fruits = c("cherry", "marionberry", "mountain_apple")
maf[, group := sample(fruits, size = 1), by = "Unique_Patient_Identifier"]

luad = load_maf(cesa = CESAnalysis(refset = "ces.refset.hg19", sample_groups = fruits), maf = maf, group_col = "group")
saveRDS(luad, "annotated_fruit_cesa.rds")


# signatures and trinuc rates
luad = trinuc_mutation_rates(luad, signature_set = "COSMIC_v3.2",
                             signatures_exclusions = suggest_cosmic_signatures_to_remove("LUAD", treatment_naive = TRUE, quiet = TRUE))

fwrite(luad$trinuc_rates, "luad_hg19_trinuc_rates.txt", sep = "\t")
fwrite(luad$mutational_signatures$raw_attributions, "luad_hg19_sig_table_with_artifacts.txt", sep = "\t")
fwrite(luad$mutational_signatures$biological_weights, "luad_hg19_sig_table_biological.txt", sep = "\t")

# To generate test data for dndscv,
# run gene_mutation_rates(luad, covariates = "lung") with breakpoints before/after run_dndscv
# and save the input list and raw output to the .rds files. Also save the fit object, because
# a necessary component for generating it won't be saved with the raw output .rds.

luad = gene_mutation_rates(luad, covariates = "lung", sample_group = "marionberry")
luad = gene_mutation_rates(luad, covariates = "lung", sample_group = c("cherry", "mountain_apple"))
fwrite(luad$gene_rates, "luad_fruit_gene_rates.txt", sep = "\t")


# save results to serve as expected test output
test_genes = c("EGFR", "ASXL3", "KRAS", "RYR2", "USH2A", "CSMD3", "TP53", "CSMD1", "LRP1B", 
               "ZFHX4", "FAT3", "CNTNAP5", "PCDH15", "NEB", "RYR3", "DMD", "KATNAL1", 
               "OR13H1", "KSR1")
luad = ces_variant(luad, variants = select_variants(luad, genes = test_genes))
fwrite(luad@selection_results[[1]], "fruit_sswm_out.txt", sep = "\t")

# Three big genes and a variant that is the only mutation in its gene in the data set
luad = ces_variant(luad, select_variants(luad, genes = c("EGFR", "KRAS", "TP53"), variant_ids = "CR2 R247L"),
               model = "sswm_sequential", groups = list(c("marionberry", "cherry"), "mountain_apple"))
fwrite(luad@selection_results[[2]], "fruit_sswm_sequential_out.txt", sep = "\t")

luad = ces_gene_epistasis(luad, genes = c("EGFR", "KRAS", "TP53"), conf = .95)
saveRDS(luad$epistasis[[1]], "epistasis_results.rds")

setwd(prev_dir)






