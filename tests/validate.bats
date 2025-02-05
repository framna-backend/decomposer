bats_load_library bats-assert
bats_load_library bats-support

load helpers/variables
load helpers/hooks
load helpers/main
load helpers/creations

# This suite tests the "validate" command

SUITE_NAME=$( test_suite_name )

@test "${SUITE_NAME}: valid decomposer.json file" {
  create_decomposer_json alpha_psr4 beta_psr0 gamma_psr0

  run_decomposer validate
  assert_success
  assert_line "Validating Alpha...OK"
  assert_line "Validating Beta...OK"
  assert_line "Validating Gamma...OK"
}

@test "${SUITE_NAME}: valid decomposer.json file with development-only indicator" {
  create_decomposer_json alpha_psr4 beta_dev gamma_psr0

  run_decomposer validate
  assert_success
  assert_line "Validating Alpha...OK"
  assert_line "Validating Beta...OK"
  assert_line "Validating Gamma...OK"
}

@test "${SUITE_NAME}: decomposer.json doesn't contain JSON content" {
  create_decomposer_json not_json_content

  run_decomposer validate
  assert_failure
  assert_line "decomposer.json is not a valid JSON object"
}

@test "${SUITE_NAME}: decomposer.json doesn't contain JSON object" {
  create_decomposer_json not_json_object

  run_decomposer validate
  assert_failure
  assert_line "decomposer.json is not a valid JSON object"
}

@test "${SUITE_NAME}: library not an object" {
  create_decomposer_json alpha_psr4 beta_not_object gamma_psr0

  run_decomposer validate
  assert_failure
  assert_line "Validating Alpha...OK"
  assert_line "Validating Beta...FAIL (not an object)"
  assert_line "Validating Gamma...OK"
}

@test "${SUITE_NAME}: library missing url" {
  create_decomposer_json alpha_psr4 beta_missing_url gamma_psr0

  run_decomposer validate
  assert_failure
  assert_line "Validating Alpha...OK"
  assert_line "Validating Beta...FAIL (invalid url)"
  assert_line "Validating Gamma...OK"
}

@test "${SUITE_NAME}: library url not a string" {
  create_decomposer_json alpha_psr4 beta_url_not_string gamma_psr0

  run_decomposer validate
  assert_failure
  assert_line "Validating Alpha...OK"
  assert_line "Validating Beta...FAIL (invalid url)"
  assert_line "Validating Gamma...OK"
}

@test "${SUITE_NAME}: library missing version" {
  create_decomposer_json alpha_psr4 beta_missing_version gamma_psr0

  run_decomposer validate
  assert_failure
  assert_line "Validating Alpha...OK"
  assert_line "Validating Beta...FAIL (invalid version)"
  assert_line "Validating Gamma...OK"
}

@test "${SUITE_NAME}: library version not a string" {
  create_decomposer_json alpha_psr4 beta_version_not_string gamma_psr0

  run_decomposer validate
  assert_failure
  assert_line "Validating Alpha...OK"
  assert_line "Validating Beta...FAIL (invalid version)"
  assert_line "Validating Gamma...OK"
}

@test "${SUITE_NAME}: library revision not a string" {
  create_decomposer_json alpha_psr4 beta_revision_not_string gamma_psr0

  run_decomposer validate
  assert_failure
  assert_line "Validating Alpha...OK"
  assert_line "Validating Beta...FAIL (invalid revision)"
  assert_line "Validating Gamma...OK"
}

@test "${SUITE_NAME}: library target-dir not a string" {
  create_decomposer_json alpha_psr4 beta_target_dir_not_string gamma_psr0

  run_decomposer validate
  assert_failure
  assert_line "Validating Alpha...OK"
  assert_line "Validating Beta...FAIL (invalid target-dir)"
  assert_line "Validating Gamma...OK"
}

@test "${SUITE_NAME}: library missing psr0 or psr4" {
  create_decomposer_json alpha_psr4 beta_missing_psr gamma_psr0

  run_decomposer validate
  assert_failure
  assert_line "Validating Alpha...OK"
  assert_line "Validating Beta...FAIL (missing psr0 or psr4)"
  assert_line "Validating Gamma...OK"
}

@test "${SUITE_NAME}: library conflicting psr0 and psr4" {
  create_decomposer_json alpha_psr4 beta_conflicting_psr gamma_psr0

  run_decomposer validate
  assert_failure
  assert_line "Validating Alpha...OK"
  assert_line "Validating Beta...FAIL (conflicting psr0 and psr4)"
  assert_line "Validating Gamma...OK"
}

@test "${SUITE_NAME}: library dev not a boolean" {
  create_decomposer_json alpha_psr4 beta_dev_not_boolean gamma_psr0

  run_decomposer validate
  assert_failure
  assert_line "Validating Alpha...OK"
  assert_line "Validating Beta...FAIL (invalid development-only indicator)"
  assert_line "Validating Gamma...OK"
}
