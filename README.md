# mlr3learners.ksvm

<!-- badges: start -->

[![R CMD Check via {tic}](https://github.com/mlr3learners/mlr3learners.ksvm/workflows/R%20CMD%20Check%20via%20{tic}/badge.svg?branch=master)](https://github.com/mlr3learners/mlr3learners.ksvm/actions)
[![codecov](https://codecov.io/gh/mlr3learners/mlr3learners.ksvm/branch/master/graph/badge.svg)](https://codecov.io/gh/mlr3learners/mlr3learners.ksvm)
[![StackOverflow](https://img.shields.io/badge/stackoverflow-mlr3-orange.svg)](https://stackoverflow.com/questions/tagged/mlr3)
<!-- badges: end -->

Adds `ksvm()` from the {kernlab} package to {mlr3}.

Install the latest release of the package via 

```r
install.packages("mlr3learners.ksvm")
```

by following the instructions in the [mlr3learners.drat README](https://github.com/mlr3learners/mlr3learners.drat).

Alternatively, you can install the latest version of {mlr3learners.ksvm} from Github with:

```r
remotes::install_github("mlr3learners/mlr3learners.ksvm")
```

## Supported kernels

- `rbfdot`
- `polydot`
- `vanilladot`
- `laplacedot`
- `besseldot`
- `anovadot`

## Currently unsupported kernels

- `tanhdot`
- `splinedot`
- `stringdot`
