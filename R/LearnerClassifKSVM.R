#' @title Classification Kernlab Support Vector Machine
#'
#' @aliases mlr_learners_classif.ksvm
#' @format [R6::R6Class] inheriting from [LearnerClassif].
#'
#' @description
#' A [LearnerClassif] for a classification support vector machine implemented in [kernlab::ksvm()] in package \CRANpkg{kernlab}.
#'
#' @references
#' Alexandros Karatzoglou, Alex Smola, Kurt Hornik, Achim Zeileis (2004).
#' kernlab - An S4 Package for Kernel Methods in R. Journal of Statistical Software 11(9), 1-20.
#' \url{http://www.jstatsoft.org/v11/i09/}
#'
#' @export
LearnerClassifKSVM = R6Class("LearnerClassifKSVM", inherit = LearnerClassif,
  public = list(
    initialize = function(id = "classif.ksvm") {
      super$initialize(
        id = id,
        packages = "kernlab",
        feature_types = c("numeric", "factor", "ordered"), # which feature types are supported? Must be a subset of mlr_reflections$task_feature_types
        predict_types = c("response", "prob"), # which predict types are supported? See mlr_reflections$learner_predict_types
        param_set = ParamSet$new( #the defined parameter set, now with the paradox package. See readme.rmd for more details
          params = list(
            ParamLgl$new(id = "scaled", default = TRUE, tags = c("train")),
            ParamFct$new(id = "type", default = "C-svc", levels = c("C-svc", "nu-svc", "C-bsvc", "spoc-svc", "kbb-svc"), tags = c("train")),
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
        properties = c("weights", "twoclass", "multiclass", "importance", "oob_error") #see mlr_reflections$learner_properties
      )
    },

    train_internal = function(task) {
      pars = self$param_set$get_values(tags = "train")
      f = task$formula()
      data = task$data()
      invoke(kernlab::ksvm, x = f, data = data, .args = pars)
    },

    predict_internal = function(task) {
      pars = self$param_set$get_values(tags = "predict") #get parameters with tag "predict"
      newdata = task$data(cols = task$feature_names) #get newdata
      type = ifelse(self$predict_type == "response", "response", "probabilities") #this is for the randomForest package

      p = invoke(kernlab::predict, self$model, newdata = newdata,
        type = type, .args = pars)

      #return a prediction object with PredictionClassif$new() or PredictionRegr$new()
      if (self$predict_type == "response") {
        PredictionClassif$new(task = task, response = p)
      } else {
        PredictionClassif$new(task = task, prob = p)
      }
    },

    #add method for importance, if learner supports that. It must return a sorted (decreasing) numerical, named vector.
    importance = function() {
    },

    #add method for oob_error, if learner supports that.
    oob_error = function() {
    }
  )
)
