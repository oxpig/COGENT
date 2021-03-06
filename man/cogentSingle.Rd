% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mainFunctions.R
\name{cogentSingle}
\alias{cogentSingle}
\title{Single COGENT call}
\usage{
cogentSingle(
  df,
  netwkFun,
  nodeFun = NULL,
  propShared = 0,
  align = FALSE,
  reduce = TRUE,
  nodeModes = "all",
  use = "complete.obs",
  method = "pearson",
  k.or.p = 0.1,
  scale = FALSE
)
}
\arguments{
\item{df}{A COGENT-compatible data frame with rows corresponding to genes and
columns corresponding to samples. A column called Name containing gene
names is expected.}

\item{netwkFun}{A function mapping a COGENT-compatible data frame to an
adjacency matrix.}

\item{nodeFun}{A function calculating node metrics from an adjacency matrix.
Defaults to NULL.}

\item{propShared}{Proportion of samples (from the input \code{df}) to be
shared across the two random split.}

\item{align}{Logical; Whether to align the two outputs of \code{netwkFun}.
Only set to TRUE if \code{netwkFun()} doesn't preserve gene order.}

\item{reduce}{Logical; Whether mutually isolated nodes should be handled 
separately. Default is TRUE.}

\item{nodeModes}{Which modes of comparison to use for node metrics. This
should be either \code{"all"} or a subset of \{\code{"cor"}, \code{"ksim"},
\code{"L2"}\}. Ignored if \code{nodeFun=NULL}.}

\item{use}{Further argument for node comparison, see
\code{\link[stats]{cor}}.}

\item{method}{Further argument for node comparison, see
\code{\link[stats]{cor}}.}

\item{k.or.p}{Further argument for node comparison, see
\code{\link{calculateKSimilarity}}.}

\item{scale}{Further argument for node comparison, see
\code{\link{calculateEuclideanDistance}}.}
}
\value{
The result is a list of similarity measures of the two gene
  expression networks generated by randomly splitting the samples in two
  groups. If \code{nodeFun=NULL} this includes:
  \itemize{
  \item \code{nodeCount} The number of non-isolated genes across the two
  networks.
  \item \code{globalSimilarity} The weighted Jaccard index of the edge
  sets of the two networks.
  \item \code{localSimilarity} The weighted Jaccard index for
  each gene neighbourhood.
  }
  If a node metric has been specified, this is also calculated and network
  similarity is measured with respect to the metric. A subset of the
  following metrics is returned in addition to the network metric:
  \itemize{
  \item \code{corSimilarity} The correlation coefficient between the two
  node metric vectors.
  \item \code{ksimSimilarity} The rank k-similarity between the two node
  metric vectors.
  \item \code{L2Distance} The Euclidean \emph{distance} between
  the two node metric vectors.
  }
}
\description{
\code{cogentSingle()} will randomly split a gene expression data frame
\code{df} in two, construct two separate adjacency matrices by applying the
\code{netwkFun()} function to each partition and compare the results.
}
\examples{
# Generate some expression data
df <- as.data.frame(matrix(runif(500), nrow=10, ncol=50))
df <- cbind(Name=LETTERS[1:10], df)
# Construct co-expression networks by thresholding the Pearson correlation
# coefficient at 0.20.
foo <- function(df){
    A <- cor(t(df[,colnames(df)!="Name"]))
    A <- 1*(A>0.20)
    return(A)
}
# Use the degree as a node metric
fooNode <- function(x) rowSums(x)
# Calculate stability:
## Without node metric comparison
cogentSingle(df, foo)
## With all types of node metric comparison
cogentSingle(df, foo, fooNode)
## With node metric comparison using Spearman correlation
## and rank k-similarity
cogentSingle(df, foo, fooNode, nodeModes=c("cor", "ksim"), method="spearman")

}
