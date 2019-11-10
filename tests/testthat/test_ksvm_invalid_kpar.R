context("ksvm.invalid.kpar")

test_wrong_kpar = function(kernel) {
  expect_error(do.call(lrn, args = append(list("regr.ksvm", kernel = kernel), invalid_kpars)))
  expect_error(do.call(lrn, args = append(list("classif.ksvm", kernel = kernel), invalid_kpars)))
}

invalid_kpars = list(sigma = 5, degree = 5, scale = 2, offset = 10, order = 2)
test_wrong_kpar("rbfdot")
test_wrong_kpar("polydot")
test_wrong_kpar("vanilladot")
test_wrong_kpar("laplacedot")
test_wrong_kpar("anovadot")
test_wrong_kpar("besseldot")
