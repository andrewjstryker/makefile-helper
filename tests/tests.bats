#!/usr/bin/env bats
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
#
# Our testing strategy is to compare the results of `make help` to snapshots.
# We test against two snapshots:
#   1. Project `Makefile`--we need to be sure that the project works correctly
#      against its own `Makefile`.
#   2. Generated `Makefile`--we need a way to test the embedded version.
#
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#

setup() {
  # store testing working directory
  DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"

  # make executables in src/ visible to PATH
  PATH="$DIR/..:$PATH"

  load test_helper/bats-support/load
  load test_helper/bats-assert/load
}

#-----------------------------------------------------------------------------#
#
# Test the project Makefile
#
#-----------------------------------------------------------------------------#

@test "Compare AWK output to the project Makefile snapshot" {
  f=$(mktemp -t project-makefile.XXXXXX)
  generate-help.awk ${DIR}/../Makefile > $f
  run diff $f ${DIR}/snapshots/project-makefile
  assert_success
  rm -f $f
}

#-----------------------------------------------------------------------------#
#
# Test the testing Makefile
#
#-----------------------------------------------------------------------------#

@test "Compare AWK output to the testing Makefile snapshot" {
  f=$(mktemp -t testing-awk-makefile.XXXXXX)
  make -f awk.makefile help | grep -v "^make" > $f
  run diff $f ${DIR}/snapshots/testing-makefile
  assert_success
  rm -f $f
}

@test "Compare embedded ouput to testing snapshot" {
  f=$(mktemp -t testing-embedded-outfile.XXXXXX)
  make -f embed.makefile help | grep -v "^make" > $f
  run diff $f ${DIR}/snapshots/testing-makefile
  assert_success
  rm -f $f
}

# vim: ft=bash
