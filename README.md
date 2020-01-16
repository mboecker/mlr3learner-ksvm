# mlr3learners.ksvm

<!-- badges: start -->
[![Build Status](https://img.shields.io/travis/mlr3learners/mlr3learners.ksvm/master?label=Linux&logo=travis&style=flat-square)](https://travis-ci.org/mlr3learners/mlr3)
[![Build status](https://ci.appveyor.com/api/projects/status/74tcko9g6r8e070o?svg=true)](https://ci.appveyor.com/project/mlr3learners/mlr3learners-ksvm)
[![codecov](https://codecov.io/gh/mlr3learners/mlr3learner.ksvm/branch/master/graph/badge.svg)](https://codecov.io/gh/mlr3learners/mlr3learners.ksvm)
[![StackOverflow](https://img.shields.io/badge/stackoverflow-mlr3-orange.svg)](https://stackoverflow.com/questions/tagged/mlr3)
<!-- badges: end -->

This package wraps the `ksvm` Support Vector Machine from the `kernlab` package for use in `mlr3`.
For for information on how to use this learner with `mlr3`, visit https://github.com/mlr3learners/mlr3learners and the [book](https://mlr3book.mlr3learners.com).

# Supported kernels:
- `rbfdot`
- `polydot`
- `vanilladot`
- `laplacedot`
- `besseldot`
- `anovadot`

# Currently unsupported kernels:
- `tanhdot`
- `splinedot`
- `stringdot`
