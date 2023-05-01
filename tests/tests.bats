#!/usr/bin/env bats

setup() {
  # store testing working directory
  DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"

  # make executables in src/ visible to PATH
  PATH="$DIR/..:$PATH"

  load test_helper/bats-support/load
  load test_helper/bats-assert/load
}

@test "Compare AWK file output to snapshot" {
  f=$(mktemp -t project-makefile.XXXXXX)
  generate-help.awk ${DIR}/../Makefile > $f
  run diff $f ${DIR}/snapshots/project-makefile
  assert_success
  rm -f $f
}

# vim: ft=bash
