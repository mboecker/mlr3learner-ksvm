context("ksvm.kpar")

test_kpar = function(kernel, kpar) {
  set.seed(6)

  learner = LearnerRegrKSVM$new()
  learner$param_set$values = mlr3misc::insert_named(
    learner$param_set$values,
    append(list(kernel = kernel), kpar)
  )
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)

  learner = LearnerClassifKSVM$new()
  learner$param_set$values = mlr3misc::insert_named(
    learner$param_set$values,
    append(list(kernel = kernel), kpar)
  )
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
}

# working:
test_kpar("rbfdot", list(sigma = 5))
test_kpar("polydot", list(degree = 5, scale = 2, offset = 10))
test_kpar("vanilladot", list())
test_kpar("laplacedot", list(sigma = 5))
test_kpar("anovadot", list(sigma = 5, degree = 3))
test_kpar("besseldot", list(sigma = 5, degree = 2, order = 2))

# broken:
# test_kpar("tanhdot", list(scale = 1, offset = 2))
# test_kpar("splinedot", list())