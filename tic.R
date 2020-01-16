# installs dependencies, runs R CMD check, runs covr::codecov()
do_package_checks()

do_drat(repo = "mlr3learners/mlr3learners.drat")