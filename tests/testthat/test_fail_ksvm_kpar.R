context("ksvm.fail.kpar")

fail_kpar = function(kernel) {
  kpar = list(sigma = 5, degree = 5, scale = 2, offset = 10, order = 2)

  expect_error(do.call(lrn, args = append(list("regr.ksvm", kernel = kernel), kpar)), "Condition for")
  expect_error(do.call(lrn, args = append(list("classif.ksvm", kernel = kernel), kpar)), "Condition for")
}

fail_kpar("rbfdot")
fail_kpar("polydot")
fail_kpar("vanilladot")
fail_kpar("laplacedot")
fail_kpar("anovadot")
fail_kpar("besseldot")
