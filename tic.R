# R CMD check
if (!ci_has_env("PARAMTEST")) {
  do_package_checks()
} else {
  # PARAMTEST
  get_stage("install") %>%
    add_step(step_install_deps())

  get_stage("script") %>%
    add_code_step(remotes::install_dev("mlr3")) %>%
    add_code_step(testthat::test_dir(system.file("paramtest",
      package = "mlr3learners.kernlab"),
    stop_on_failure = TRUE))
}

if (ci_has_env("DRAT")) {
  get_stage("deploy") %>%
    # remove devel version indicator to enable deployment
    add_code_step(gsub(".9000", "", readLines("DESCRIPTION")))
  do_drat("mlr3learners/mlr3learners.drat")
}
