% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DATASET_doc.R
\docType{data}
\name{continuousY_continuousM}
\alias{continuousY_continuousM}
\title{A Sample Data for Analysis}
\format{
## `continuousY_continuousM`
A data frame with 500 rows and 5 columns:
\describe{
  \item{A}{Binary treatment variable}
  \item{M}{Normally distributed mediator variable}
  \item{Y}{Normally distributed outcome variable}
  \item{X}{Uniformly distributed measure confounder within the range of (0,1)}
  \item{U}{Normally distributed unmeasured confounder}
}
}
\usage{
continuousY_continuousM
}
\description{
A Sample Data for Analysis
}
\examples{
\donttest{
# data generated with the following Data Generating Process (DGP)
generate_data <- function(n,
parA = c(0.3,0.2),
parU=c(1,1,1,0),
parM = c(1,1,1,0),
parY = c(1, 1, 1, 0),
sd.M=1, sd.U=1, sd.Y=1){

X <- runif(n, 0, 1) # p(X)

A <- rbinom(n, 1, (parA[1] + parA[2]*X)) # p(A|X)

 U <- parU[1] + parU[2]*A + parU[3]*X + parU[4]*A*X + rnorm(n,0,sd.U) # p(U|A,X)

 M <- parM[1] + parM[2]*A + parM[3]*X + parM[4]*A*X + rnorm(n,0,sd.M) # p(M|A,X)

 Y <- parY[1]*U + parY[2]*M + parY[3]*X + parY[4]*M*X + rnorm(n, 0, sd.Y) # p(Y|U,M,X)

 data <- data.frame(X=X, U=U, A=A, M=M, Y=Y)

 # propensity score
 ps <- A*(parA[1] + parA[2]*X)+(1-A)*(1-(parA[1] + parA[2]*X))

 # mediator density ratio: p(M|a,X)/p(M|A,X)
 m.ratio.a1 <- dnorm(M,parM[1] + parM[2]*1 + parM[3]*X + parM[4]*1*X,sd.M)/
 dnorm(M,parM[1] + parM[2]*A + parM[3]*X + parM[4]*A*X,sd.M)
 m.ratio.a0 <- dnorm(M,parM[1] + parM[2]*0 + parM[3]*X + parM[4]*0*X,sd.M)/
 dnorm(M,parM[1] + parM[2]*A + parM[3]*X + parM[4]*A*X,sd.M)

 return(list(data = data,
           parA=parA,
           parU=parU,
           parM=parM,
           parY=parY,
           sd.U=sd.U,
           sd.Y=sd.Y,
           sd.M=sd.M,
           ps=ps,
           m.ratio.a1=m.ratio.a1,
           m.ratio.a0=m.ratio.a0))
 }

}

}
\keyword{datasets}
