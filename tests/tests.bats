#!/usr/bin/env bats
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
#
# Our testing strategy is to compare the results of `make help` to snapshots.
# We test against two snapshots:
#   1. Project `Makefile`--we need to be sure that the project works correctly
#      against its own `Makefile`.
#   2. Generated `Makefile`s for all possible cominations
#
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#

setup() {
  # store testing working directory
  DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"

  # place the bats executable on the path
  PATH="${DIR}/bats/bin:${DIR}/..:${PATH}"

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
# Test all cases
#
#-----------------------------------------------------------------------------#

@test "Compare embed ouptput for none and none" {
  f=$(mktemp -t none-none-embed.XXXXXX)
  make -f none-none-embed.makefile help | grep -v "^make" > $f
  run diff $f ${DIR}/snapshots/none-none
  assert_success
  rm -f $f
}

@test "Compare embed ouptput for special and none" {
  f=$(mktemp -t special-none-embed.XXXXXX)
  make -f special-none-embed.makefile help | grep -v "^make" > $f
  run diff $f ${DIR}/snapshots/special-none
  assert_success
  rm -f $f
}

@test "Compare embed ouptput for env and none" {
  f=$(mktemp -t env-none-embed.XXXXXX)
  make -f env-none-embed.makefile help | grep -v "^make" > $f
  run diff $f ${DIR}/snapshots/env-none
  assert_success
  rm -f $f
}

@test "Compare embed ouptput for all and none" {
  f=$(mktemp -t all-none-embed.XXXXXX)
  make -f all-none-embed.makefile help | grep -v "^make" > $f
  run diff $f ${DIR}/snapshots/all-none
  assert_success
  rm -f $f
}

@test "Compare AWK ouptput for none and none" {
  f=$(mktemp -t none-none-awk.XXXXXX)
  make -f none-none-awk.makefile help | grep -v "^make" > $f
  run diff $f ${DIR}/snapshots/none-none
  assert_success
  rm -f $f
}

@test "Compare AWK ouptput for special and none" {
  f=$(mktemp -t special-none-awk.XXXXXX)
  make -f special-none-awk.makefile help | grep -v "^make" > $f
  run diff $f ${DIR}/snapshots/special-none
  assert_success
  rm -f $f
}

@test "Compare AWK ouptput for env and none" {
  f=$(mktemp -t env-none-awk.XXXXXX)
  make -f env-none-awk.makefile help | grep -v "^make" > $f
  run diff $f ${DIR}/snapshots/env-none
  assert_success
  rm -f $f
}

@test "Compare AWK ouptput for all and none" {
  f=$(mktemp -t all-none-awk.XXXXXX)
  make -f all-none-awk.makefile help | grep -v "^make" > $f
  run diff $f ${DIR}/snapshots/all-none
  assert_success
  rm -f $f
}

@test "Compare embed ouptput for none and env" {
  f=$(mktemp -t none-env-embed.XXXXXX)
  make -f none-env-embed.makefile help | grep -v "^make" > $f
  run diff $f ${DIR}/snapshots/none-env
  assert_success
  rm -f $f
}

@test "Compare embed ouptput for special and env" {
  f=$(mktemp -t special-env-embed.XXXXXX)
  make -f special-env-embed.makefile help | grep -v "^make" > $f
  run diff $f ${DIR}/snapshots/special-env
  assert_success
  rm -f $f
}

@test "Compare embed ouptput for env and env" {
  f=$(mktemp -t env-env-embed.XXXXXX)
  make -f env-env-embed.makefile help | grep -v "^make" > $f
  run diff $f ${DIR}/snapshots/env-env
  assert_success
  rm -f $f
}

@test "Compare embed ouptput for all and env" {
  f=$(mktemp -t all-env-embed.XXXXXX)
  make -f all-env-embed.makefile help | grep -v "^make" > $f
  run diff $f ${DIR}/snapshots/all-env
  assert_success
  rm -f $f
}

@test "Compare AWK ouptput for none and env" {
  f=$(mktemp -t none-env-awk.XXXXXX)
  make -f none-env-awk.makefile help | grep -v "^make" > $f
  run diff $f ${DIR}/snapshots/none-env
  assert_success
  rm -f $f
}

@test "Compare AWK ouptput for special and env" {
  f=$(mktemp -t special-env-awk.XXXXXX)
  make -f special-env-awk.makefile help | grep -v "^make" > $f
  run diff $f ${DIR}/snapshots/special-env
  assert_success
  rm -f $f
}

@test "Compare AWK ouptput for env and env" {
  f=$(mktemp -t env-env-awk.XXXXXX)
  make -f env-env-awk.makefile help | grep -v "^make" > $f
  run diff $f ${DIR}/snapshots/env-env
  assert_success
  rm -f $f
}

@test "Compare AWK ouptput for all and env" {
  f=$(mktemp -t all-env-awk.XXXXXX)
  make -f all-env-awk.makefile help | grep -v "^make" > $f
  run diff $f ${DIR}/snapshots/all-env
  assert_success
  rm -f $f
}


# vim: ft=bash
