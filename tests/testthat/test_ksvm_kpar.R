context("ksvm.kpar")

test_kpar = function(kernel, kpar) {
  learner = LearnerRegrKSVM$new()
  learner$param_set$values = mlr3misc::insert_named(
    learner$param_set$values,
    list(kernel = kernel, kpar = kpar)
  )
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)

  learner = LearnerClassifKSVM$new()
  learner$param_set$values = mlr3misc::insert_named(
    learner$param_set$values,
    list(kernel = kernel, kpar = kpar)
  )
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
}

test_kpar("rbfdot", list(sigma = 5))
test_kpar("polydot", list(degree = 5, scale = 2, offset = 10))
