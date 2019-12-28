# mlr3learner-ksvm

[![Build Status](https://travis-ci.org/mlr3learners/mlr3learners.ksvm.svg?branch=master)](https://travis-ci.org/mlr3learners/mlr3learners.ksvm)

This package wraps the `ksvm` Support Vector Machine from the `kernlab` package for use in `mlr3`.
For for information on how to use this learner with `mlr3`, visit https://github.com/mlr-org/mlr3learners and the [book](https://mlr3book.mlr-org.com).

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
