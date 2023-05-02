#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
#
#> Makefile stub for testing purposes
#>
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#

#-----------------------------------------------------------------------------#
#
# User interface
#
#-----------------------------------------------------------------------------#

default: all # Notice that a regular comment, such as these ones, will not
	# appear in the generated help message

all: embed #> Generate all derived files (currently only embed)

embed: ${embed_file} #> Generate the embeddable target and recipe

install: #! Install this file to the system
	install ${awk_src} /usr/local/bin

test: #> Run the test suite
	./tests/tests.bats

release: all #! Place artifacts on GitHub
	# find the most recent version tag
	tag=$$(git tag --list 'v*' | head -1); \
	echo "Creating a release for version $${tag}"; \
	gh release create $${tag} ${release_artifacts}

clean: #> Remove generated files
	rm -f ${generated_files}

help: #> Display this help message
