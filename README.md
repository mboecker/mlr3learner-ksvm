# mlr3learners.ksvm

<!-- badges: start -->
[![Build Status](https://img.shields.io/travis/mlr3learners/mlr3learners.ksvm/master?label=Linux&logo=travis&style=flat-square)](https://travis-ci.org/mlr3learners/mlr3)
[![Build status](https://ci.appveyor.com/api/projects/status/j3qif5mvjmnlb412?svg=true)](https://ci.appveyor.com/project/mlr3learners/mlr3learners-ksvm)
[![codecov](https://codecov.io/gh/mlr3learners/mlr3learners.ksvm/branch/master/graph/badge.svg)](https://codecov.io/gh/mlr3learners/mlr3learners.ksvm)
[![StackOverflow](https://img.shields.io/badge/stackoverflow-mlr3-orange.svg)](https://stackoverflow.com/questions/tagged/mlr3)
[![R CMD Check via {tic}](https://img.shields.io/github/workflow/status/mlr3learners/mlr3learners.ksvm/R%20CMD%20Check%20via%20%7Btic%7D?logo=github&label=R%20CMD%20Check%20via%20{tic}&style=flat-square)](https://github.com/mlr3learners/mlr3learners.ksvm/actions)
<!-- badges: end -->

Adds `ksvm()` from the `{kernlab}` package to `{mlr3}`.

Install the latest release of the package via 

```r
install.packages("mlr3learners.ksvm")
```

by following the instructions in the [mlr3learners.drat](https://github.com/mlr3learners/mlr3learners.drat) README.


Alternatively, you can install the latest version of `mlr3learners.ksvm` from Github with:

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
