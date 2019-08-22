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
      super$initialize(
        id = id,
        packages = "kernlab",
        feature_types = c("numeric", "factor", "ordered"),
        predict_types = c("response"),
        param_set = ParamSet$new( #the defined parameter set, now with the paradox package. See readme.rmd for more details
          params = list(
            ParamLgl$new(id = "scaled", default = TRUE, tags = c("train")),
            ParamFct$new(id = "type", default = "eps-svr", levels = c("eps-svr", "nu-svc", "eps-bsvr"), tags = c("train")),
            ParamUty$new(id = "kernel", default = "rbfdot", tags = c("train")),
            ParamDbl$new(id = "C", default = 1, tags = c("train")),
            ParamDbl$new(id = "nu", default = 0.2, tags = c("train")),
            ParamDbl$new(id = "epsilon", default = 0.1, tags = c("train")),
            ParamDbl$new(id = "cache", default = 40, tags = c("train")),
            ParamDbl$new(id = "tol", default = 0.001, tags = c("train")),
            ParamLgl$new(id = "shrinking", default = TRUE, tags = c("train"))
          )
        ),
        param_vals = list(),
        properties = c("weights") #see mlr_reflections$learner_properties
      )
    },

    train_internal = function(task) {
      pars = self$param_set$get_values(tags = "train")
      f = task$formula()
      data = task$data()
      invoke(kernlab::ksvm, x = f, data = data, prob.model = self$predict_type == "prob", .args = pars)
    },

    predict_internal = function(task) {
      pars = self$param_set$get_values(tags = "predict") #get parameters with tag "predict"
      newdata = task$data(cols = task$feature_names) #get newdata

      predict_type = ifelse(self$predict_type == "se", "votes", "response")
      p = invoke(kernlab::predict, self$model, newdata = newdata, type = predict_type, .args = pars)

      PredictionRegr$new(task = task, response = p)
    }
  )
)
