context("ksvm.kpar")

test_kpar = function(kernel, kpar) {
  set.seed(6)

  learner = do.call(lrn, args = append(list("regr.ksvm", kernel = kernel), kpar))
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)

  learner = do.call(lrn, args = append(list("classif.ksvm", kernel = kernel), kpar))
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
}

fail_kpar = function(kernel) {
  set.seed(6)

  kpar = list(sigma = 5, degree = 5, scale = 2, offset = 10, order = 2)

  expect_error(do.call(lrn, args = append(list("regr.ksvm", kernel = kernel), kpar)), "Condition for")
  expect_error(do.call(lrn, args = append(list("classif.ksvm", kernel = kernel), kpar)), "Condition for")
}

# working:
test_kpar("rbfdot", list(sigma = 5))
test_kpar("polydot", list(degree = 5, scale = 2, offset = 10))
test_kpar("vanilladot", list())
test_kpar("laplacedot", list(sigma = 5))
test_kpar("anovadot", list(sigma = 5, degree = 3))
test_kpar("besseldot", list(sigma = 5, degree = 2, order = 2))

fail_kpar("rbfdot")
fail_kpar("polydot")
fail_kpar("vanilladot")
fail_kpar("laplacedot")
fail_kpar("anovadot")
fail_kpar("besseldot")

# broken:
# test_kpar("tanhdot", list(scale = 1, offset = 2))
# test_kpar("splinedot", list())