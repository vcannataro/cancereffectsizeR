% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gene_mutation_rates.R
\name{gene_mutation_rates}
\alias{gene_mutation_rates}
\title{Use dNdScv with tissue-specific covariates to calculate gene-level mutation rates}
\usage{
gene_mutation_rates(
  cesa,
  covariates = NULL,
  samples = character(),
  dndscv_args = list(),
  save_all_dndscv_output = FALSE,
  sample_group = NULL
)
}
\arguments{
\item{cesa}{CESAnalysis object}

\item{covariates}{Tissue-specific mutation rate covariates. Typically, supply the
covariates object from your refset (e.g., ces.refset.hg19$covariates$bladder), or the
object name ("bladder"). Run list_ces_covariates() to see choices. For hg19 data
only, set to "hg19" to use dNdScv's non-tissue-specific covariates. If no appropriate
covariates data are available, set to NULL to run without. Finally, you can also
supply custom covariates data in the form of a matrix or prcomp object (see website
for details).}

\item{samples}{Which samples to include in the current run. Defaults to all samples. Can be a
vector of Unique_Patient_Identifiers, or a data.table containing rows from the CESAnalysis
sample table.}

\item{dndscv_args}{Custom arguments to pass to dNdScv. (The arguments \code{mutations},
\code{gene_list}, \code{cv}, and \code{refdb} are supplied by cancereffectsizeR and can't be
substituted.)}

\item{save_all_dndscv_output}{Default FALSE; when TRUE, saves all dndscv output, not
just what's needed by cancereffectsizeR. (Full output can be very large, in the gigabytes.)}

\item{sample_group}{Which sample groups to include in the gene rate calculation;
defaults to all groups. (To calculate different rates for different groups, you'll 
run this function multiple times, changing this argument each time.)}
}
\value{
CESAnalysis object with gene-level mutation rates calculated
}
\description{
This function calculates gene-level neutral mutation rates based on counts
of nonsynonymous and synonymous mutations per gene under the dNdScv package's model, 
as described in \href{https://doi.org/10.1016/j.cell.2017.09.042}{Martincorena et al.}
}
