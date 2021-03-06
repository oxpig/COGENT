#' COGENT: A package for evaluating the Consistency of Gene Expression NeTworks
#'
#' In a gene expression network nodes represent genes and edges typically
#' represent similarity of gene expression across a number of samples. There
#' exist many ways of constructing such networks. COGENT provides a suite of
#' tools for assessing the consistency or stability of network construction
#' methods.
#'
#' @section Subsetting the data:
#'
#'   A gene expression network construction method is any function which maps a
#'   gene expression dataset to a network. It is considered consistent if it
#'   produces similar networks when subsets of the original gene expression
#'   samples are used. The main COGENT functions work by repeatedly splitting
#'   the data in two (possibly overlapping) groups of samples, constructing a
#'   network from each sample group, and measuring the similarity of the two
#'   networks.
#'
#' @section Network similarity:
#'
#'   The similarity of two networks is primarily measured by a weighted or
#'   unweighted Jaccard index between their edge sets. In the case of binary
#'   (i.e. unweighted) networks, a density correction using networks generated
#'   by a configuration model can be applied.
#'
#'   Networks may have significantly different topology, but still identify
#'   similar nodes of interest. For example, we may think of the rail network
#'   and the road network in England as similar, because they both identify the
#'   same big cities as major hubs. Therefore, it is also possible to measure
#'   network similarity by node metric agreement. For this comparison, a
#'   user-defined metric of interest is used.
#'
#' @section Uses:
#'
#'   COGENT can be used to choose between different network construction methods
#'   -- e.g. between calculating Pearson or Kendall correlation coefficients to
#'   measure co-expression. With density correction, it can also be used for
#'   informing threshold choice when this is required for building unweighted
#'   networks. For examples, please refer to the COGENT tutorial notebook.
#'
#' @docType package
#' @name COGENT
#' @importFrom igraph as_adjacency_matrix
#' @importFrom igraph sample_degseq
#' @importFrom parallel mclapply
#' @importFrom stats cor
#' @import Matrix
NULL
