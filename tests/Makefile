#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
#
#> Build and run test suite
#>
#
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#

#-----------------------------------------------------------------------------#
#
# Configuration
#
#-----------------------------------------------------------------------------#

.PHONY: clean all default test help

# Set PATH to use our version of BATS rather than the host system (if present)
PATH := ${PWD}/bats/bin:${PATH}

# variables inherited from the project Makefile
awk_src ?= ../generate-help.awk
embed_file ?= ../help-target.makefile

# stubs for generating test cases
makefile_tests = \
  none-none-awk.makefile none-none-embed.makefile \
  all-none-awk.makefile all-none-embed.makefile \
  special-none-awk.makefile special-none-embed.makefile \
  env-none-awk.makefile env-none-embed.makefile \
  none-env-awk.makefile none-env-embed.makefile \
  all-env-awk.makefile all-env-embed.makefile \
  special-env-awk.makefile special-env-embed.makefile \
  env-env-awk.makefile env-env-embed.makefile

#-----------------------------------------------------------------------------#
#
# User interface
#
#-----------------------------------------------------------------------------#

default: all

all: test

test: tests.bats ${makefile_tests} #> Run the test suite
	echo $${PATH}
	bats $<

clean: #> Remove generated files
	rm -f ${makefile_tests}

help: #> Display this help message
	@awk -f ${awk_src} ${MAKEFILE_LIST}

#-----------------------------------------------------------------------------#
#
# System-level interface
#
#-----------------------------------------------------------------------------#

# TODO: Ideally, we would use pattern rules rather writing each rule
# explicitly

none-none-awk.makefile: ${awk_src} prefix-none suffix-none
	/bin/echo -e "\t@${awk_src} $@" | cat prefix-none - suffix-none > $@

special-none-awk.makefile: ${awk_src} prefix-special suffix-none
	/bin/echo -e "\t@${awk_src} $@" | cat prefix-special - suffix-none > $@

env-none-awk.makefile: ${awk_src} prefix-env suffix-none
	/bin/echo -e "\t@${awk_src} $@" | cat prefix-env - suffix-none > $@

all-none-awk.makefile: ${awk_src} prefix-all suffix-none
	/bin/echo -e "\t@${awk_src} $@" | cat prefix-all - suffix-none > $@

none-env-awk.makefile: ${awk_src} prefix-none suffix-env
	/bin/echo -e "\t@${awk_src} $@" | cat prefix-none - suffix-env > $@

special-env-awk.makefile: ${awk_src} prefix-special suffix-env
	/bin/echo -e "\t@${awk_src} $@" | cat prefix-special - suffix-env > $@

env-env-awk.makefile: ${awk_src} prefix-env suffix-env
	/bin/echo -e "\t@${awk_src} $@" | cat prefix-env - suffix-env > $@

all-env-awk.makefile: ${awk_src} prefix-all suffix-env
	/bin/echo -e "\t@${awk_src} $@" | cat prefix-all - suffix-env > $@

none-none-embed.makefile: ${embed_file} prefix-none suffix-none
	cat prefix-none ${embed_file} suffix-none > $@

special-none-embed.makefile: ${embed_file} prefix-special suffix-none
	cat prefix-special ${embed_file} suffix-none > $@

env-none-embed.makefile: ${embed_file} prefix-env suffix-none
	cat prefix-env ${embed_file} suffix-none > $@

all-none-embed.makefile: ${embed_file} prefix-all suffix-none
	cat prefix-all ${embed_file} suffix-none > $@

none-env-embed.makefile: ${embed_file} prefix-none suffix-env
	cat prefix-none ${embed_file} suffix-env > $@

special-env-embed.makefile: ${embed_file} prefix-special suffix-env
	cat prefix-special ${embed_file} suffix-env > $@

env-env-embed.makefile: ${embed_file} prefix-env suffix-env
	cat prefix-env ${embed_file} suffix-env > $@

all-env-embed.makefile: ${embed_file} prefix-all suffix-env
	cat prefix-all ${embed_file} suffix-env > $@

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
