if (!ci_has_env("PARAMTEST") && !ci_has_env("DRAT")) {
  do_package_checks()
} else if (ci_has_env("PARAMTEST")) {
  # PARAMTEST
  get_stage("install") %>%
    add_step(step_install_deps())

  get_stage("script") %>%
    add_code_step(remotes::install_dev("mlr3")) %>%
    add_code_step(testthat::test_dir(system.file("paramtest",
      package = "mlr3learners.kernlab"),
    stop_on_failure = TRUE))
} else if (ci_has_env("DRAT")) {
  get_stage("deploy") %>%
    # remove devel version indicator to enable deployment
    add_code_step(writeLines(gsub(".9000", "", readLines("DESCRIPTION")), "DESCRIPTION"))
  do_drat("mlr3learners/mlr3learners.drat")
}
