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
            ParamInt$new(id = "ntree", default = 500L, lower = 1L, tags = c("train", "predict")),
            ParamInt$new(id = "mtry", lower = 1L, tags = "train"),
            ParamLgl$new(id = "replace", default = TRUE, tags = "train"),
            ParamUty$new(id = "classwt", default = NULL, tags = "train"), #lower = 0
            ParamUty$new(id = "cutoff", tags = "train"), #lower = 0, upper = 1
            ParamUty$new(id = "strata", tags = "train"),
            ParamUty$new(id = "sampsize", tags = "train"), #lower = 1L
            ParamInt$new(id = "nodesize", default = 1L, lower = 1L, tags = "train"),
            ParamInt$new(id = "maxnodes", lower = 1L, tags = "train"),
            ParamFct$new(id = "importance", default = "none", levels = c("accuracy", "gini", "none"), tag = "train"), #importance is a logical value in the randomForest package.
            ParamLgl$new(id = "localImp", default = FALSE, tags = "train"),
            ParamLgl$new(id = "proximity", default = FALSE, tags = "train"),
            ParamLgl$new(id = "oob.prox", tags = "train"),
            ParamLgl$new(id = "norm.votes", default = TRUE, tags = "train"),
            ParamLgl$new(id = "do.trace", default = FALSE, tags = "train"),
            ParamLgl$new(id = "keep.forest", default = TRUE, tags = "train"),
            ParamLgl$new(id = "keep.inbag", default = FALSE, tags = "train")
          )
        ),
        param_vals = list(importance = "none"), #we set this here, because the default is FALSE in the randomForest package.
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
