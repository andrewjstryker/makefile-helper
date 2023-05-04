#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
#
#
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#

#-----------------------------------------------------------------------------#
#
# Configuration
#
#-----------------------------------------------------------------------------#

.PHONY: clean all default test awk targets help embed

# Set PATH to use our version of BATS rather than the host system (if present)
PATH := ${PWD}/bats/bin:${PATH}

# variables inherited from the project Makefile
awk_src = ../generate-help.awk
embed_file = ../help-target.makefile

stub = stub.makefile
targets = awk embed

testing_awk = awk.makefile
testing_embed = embed.makefile

generated_files = ${testing_awk} ${testing_embed}

#-----------------------------------------------------------------------------#
#
# User interface
#
#-----------------------------------------------------------------------------#

default: all

all: test

awk: ${testing_awk}

embed: ${testing_embed}

test: tests.bats ${targets}
	bats $<

help: #> Display this help message
	@awk -f ${awk_src} ${MAKEFILE_LIST}

clean: #> Remove generated file
	rm -f ${generated_files}

#-----------------------------------------------------------------------------#
#
# System-level interface
#
#-----------------------------------------------------------------------------#

${testing_awk}: ${stub} ${awk_src}
	/bin/echo -e "\t@awk -f ${awk_src} $@" | cat $< - > $@

${testing_embed}: ${stub} ${embed_file}
	cat $< ${embed_file} > $@
