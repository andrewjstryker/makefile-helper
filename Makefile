#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
#
#' Example Makefile that is compatible with generate-help.awk
#'
#' This Makefile simplifies porting configuration to new systems.
#'
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#

#-----------------------------------------------------------------------------#
#
# Makefile configuration
#
#-----------------------------------------------------------------------------#

.PHONY: default all make clean install help release test

awk_src = generate-help.awk
embed_file = help-target.makefile
generated_files = ${embed_file}

release_artifacts = ${awk_src} ${embed_file}

#-----------------------------------------------------------------------------#
#
# User interface
#
#-----------------------------------------------------------------------------#

# define the default target explictly
default: all # Notice that a regular comment, such as these ones, will not
	# appear in the generated help message

all: embed #' Generate all derived files (currently only embed)

embed: ${embed_file} #' Generate the embeddable target and recipe

install: #! Install this file to the system
	install ${awk_src} /usr/local/bin

test: #' Run the test suite
	./tests/bats/bin/bats ./tests/tests.bats

release: all #! Place artifacts on GitHub
	# find the most recent version tag
	tag=$$(git tag --list 'v*' | head -1); \
	echo "Creating a release for version $${tag}"; \
	gh release create $${tag} ${release_artifacts}

clean: #' Remove generated files
	rm -f ${generated_files}

help: #' Generate this help message
	@# beginning a command with '@' prevents Make from echoing
	@awk -f ${awk_src} $(MAKEFILE_LIST)

#-----------------------------------------------------------------------------#
#
# System-level interface
#
#-----------------------------------------------------------------------------#

${embed_file}: embed.sed ${awk_src}
	sed -f $< ${awk_src} > $@

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
#'
#' Please let me know if you find this project useful. Open an issue should
#' something not work as expected or should you have an enhancement idea.
#
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
