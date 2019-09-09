#' @title Regression Kernlab Support Vector Machine
#'
#' @aliases mlr_learners_regr.ksvm
#' @format [R6::R6Class] inheriting from [LearnerRegr].
#'
#' @description
#' A [LearnerRegr] for a regression support vector machine implemented in [kernlab::ksvm()] in package \CRANpkg{kernlab}.
#'
#' @references
#' Alexandros Karatzoglou, Alex Smola, Kurt Hornik, Achim Zeileis (2004).
#' kernlab - An S4 Package for Kernel Methods in R. Journal of Statistical Software 11(9), 1-20.
#' \url{http://www.jstatsoft.org/v11/i09/}
#'
#' @export
LearnerRegrKSVM = R6Class("LearnerRegrKSVM", inherit = LearnerRegr,
  public = list(
    initialize = function(id = "regr.ksvm") {
      ps = ParamSet$new(list(
        ParamLgl$new(id = "scaled", default = TRUE, tags = c("train")),
        ParamFct$new(id = "type", default = "eps-svr", levels = c("eps-svr", "nu-svc", "eps-bsvr"), tags = c("train")),
        ParamFct$new(id = "kernel", default = "rbfdot", levels = c("rbfdot","polydot","vanilladot","tanhdot","laplacedot","besseldot","anovadot","splinedot","stringdot"), tags = c("train")),
        ParamDbl$new(id = "C", default = 1, tags = c("train")),
        ParamDbl$new(id = "nu", default = 0.2, tags = c("train")),
        ParamDbl$new(id = "epsilon", default = 0.1, tags = c("train")),
        ParamDbl$new(id = "cache", default = 40, tags = c("train")),
        ParamDbl$new(id = "tol", default = 0.001, tags = c("train")),
        ParamLgl$new(id = "shrinking", default = TRUE, tags = c("train")),

        # kernel hyperparameters
        ParamDbl$new(id = "sigma", default = NULL, tags = c("predict", "kpar"), special_vals = list(NULL)),
        ParamInt$new(id = "degree", default = NULL, tags = c("predict", "kpar"), special_vals = list(NULL)),
        ParamDbl$new(id = "scale", default = NULL, tags = c("predict", "kpar"), special_vals = list(NULL)),
        ParamInt$new(id = "order", default = NULL, tags = c("predict", "kpar"), special_vals = list(NULL)),
        ParamDbl$new(id = "offset", default = NULL, tags = c("predict", "kpar"), special_vals = list(NULL)),
        ParamInt$new(id = "length", default = NULL, tags = c("predict", "kpar"), special_vals = list(NULL)),
        ParamDbl$new(id = "lambda", default = NULL, tags = c("predict", "kpar"), special_vals = list(NULL)),
        ParamLgl$new(id = "normalized", default = NULL, tags = c("predict", "kpar"), special_vals = list(NULL))
      ))

      ps$add_dep("sigma", "kernel", CondAnyOf$new(c("rbfdot", "laplacedot", "besseldot", "anovadot")))
      ps$add_dep("degree", "kernel", CondAnyOf$new(c("polydot", "anovadot")))
      ps$add_dep("scale", "kernel", CondAnyOf$new(c("polydot", "tanhdot")))
      ps$add_dep("order", "kernel", "besseldot")
      ps$add_dep("offset", "kernel", CondAnyOf$new(c("polydot", "tanhdot")))
      ps$add_dep("length", "kernel", "stringdot")
      ps$add_dep("lambda", "kernel", "stringdot")
      ps$add_dep("normalized", "kernel", "stringdot")

      super$initialize(
        id = id,
        packages = "kernlab",
        feature_types = c("logical", "integer", "numeric", "character", "factor", "ordered"),
        predict_types = c("response"),
        param_set = ps,
        properties = c("weights")
      )
    },

    train_internal = function(task) {
      pars = self$param_set$get_values(tags = "train")
      kpar = self$param_set$get_values(tags = "kpar")
      if(length(kpar) == 0) {
        pars$values = list(kpar = "automatic")
      } else {
        pars$values = list(kpar = kpar)
      }

      f = task$formula()
      data = task$data()
      invoke(kernlab::ksvm, x = f, data = data, class.weights = task$weights$weight, .args = pars)
    },

    predict_internal = function(task) {
      newdata = task$data(cols = task$feature_names) #get newdata

      p = invoke(kernlab::predict, self$model, newdata = newdata, type = "response")
      PredictionRegr$new(task = task, response = p)
    }
  )
)
