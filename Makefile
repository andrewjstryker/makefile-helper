#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
#
#> Example Makefile that is compatible with generate-help.awk
#>
#> This Makefile simplifies porting configuration to new systems.
#>
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#

#-----------------------------------------------------------------------------#
#
# Makefile configuration
#
#-----------------------------------------------------------------------------#

.PHONY: default all make clean install help release test

# Set PATH to use our version of BATS rather than the host system (if present)
PATH := ${PWD}/tests/bats/bin:${PATH}

awk_src = generate-help.awk
embed_file = help-target.makefile

testing_stub = tests/stub.makefile
testing_awk = tests/testing-awk.makefile
testing_embed = tests/testing-embed.makefile
testing = testing_awk testing_embed

generated_files = ${embed_file} ${testing}

release_artifacts = ${awk_src} ${embed_file}

#-----------------------------------------------------------------------------#
#
# User interface
#
#-----------------------------------------------------------------------------#

# define the default target explictly
default: all # Notice that a regular comment, such as these ones, will not
	# appear in the generated help message

all: ${generated_files} #> Generate all derived files

embed: ${embed_file} #> Generate the embeddable target and recipe

install: #! Install this file to the system
	install ${awk_src} /usr/local/bin

test: ${testing} #> Run the test suite
	./tests/tests.bats

release: all #! Place artifacts on GitHub
	# find the most recent version tag
	tag=$$(git tag --list 'v*' | head -1); \
	echo "Creating a release for version $${tag}"; \
	gh release create $${tag} ${release_artifacts}

clean: #> Remove generated files
	rm -f ${generated_files}

help: #> Generate this help message
	@# beginning a command with '@' prevents Make from echoing
	@awk -f ${awk_src} $(MAKEFILE_LIST)

#-----------------------------------------------------------------------------#
#
# System-level interface
#
#-----------------------------------------------------------------------------#

${embed_file}: embed.sed ${awk_src}
	sed -f $< ${awk_src} > $@

${testing_awk}: ${testing_stub} ${awk_src}
	cat ${testing_stub} > $@
	echo -e "\t@awk -f ../generate-help.awk \${MAKEFILE_LIST} >> $@

${testing_embed}: ${testing_stub} ${embed_file}
	cat ${embed_file} $< > $@

#-----------------------------------------------------------------------------#
#>
#> Please let me know if you find this project useful. Open an issue should
#> something not work as expected or should you have an enhancement idea.
#
#-----------------------------------------------------------------------------#
