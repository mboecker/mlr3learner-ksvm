# installs dependencies, runs R CMD check, runs covr::codecov()
do_package_checks()

# build drat package
get_stage("before_deploy") %>%
  add_step(step_setup_ssh('id_rsa'))

get_stage("deploy") %>%
  add_step(step_setup_push_deploy(
    path = "~/git/drat",
    branch = "master",
    remote = paste0("git@github.com:", gsub("/.*$", "/mlr3learners.drat", ci()$get_slug()), ".git")
  )) %>%
  add_step(step_add_to_drat()) %>%
  add_step(step_do_push_deploy(path = "~/git/drat"))