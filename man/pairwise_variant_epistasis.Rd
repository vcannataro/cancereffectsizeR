% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pairwise_epistasis.R
\name{pairwise_variant_epistasis}
\alias{pairwise_variant_epistasis}
\title{Calculate SIs at variant level under pairwise epistasis model}
\usage{
pairwise_variant_epistasis(
  cesa,
  variant_pair,
  samples,
  conf,
  compound_variants = NULL
)
}
\arguments{
\item{cesa}{CESAnalysis}

\item{variant_pair}{2-length character of variant IDs, or 2-length numeric giving
indices of CompoundVariantSet for the current two compound variants}

\item{samples}{Validated samples data.table (as from select_samples())}

\item{compound_variants}{If testing a pair of compound variants, the CompoundVariantSet defining them}
}
\description{
Calculate SIs at variant level under pairwise epistasis model
}
\keyword{internal}
