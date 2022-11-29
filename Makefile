#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
#
#' Example Makefile that is compatible with generate-help.awk
#'
#' This Makefile simplifies porting configuration to new systems.
#'
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#

# targets that are not files
.PHONY: build display verify install help remove

# define the default target explictly
default : help # Notice that a regular comment, such as these ones, will not
	# appear in the generated help message

build : #' Build the package
	echo "Build, package, build"

display : #' Display the project README file
	cat README.md

verify : #' Verify the build system and demostrate how to wrap comments for
	#' targets that require long explanations
	echo "Just another example"

install : generate-help.awk #! Install this file to the system
	install generate-help.awk /usr/local/bin

clean : #' Remove generated files
	rm -f help-target.makefile

help : #' Generate this help message
	@# beginning a command with '@' prevents Make from echoing
	@awk -f generate-help.awk $(MAKEFILE_LIST)

#-----------------------------------------------------------------------------#
#
# System targets
#
#-----------------------------------------------------------------------------#

help-target.makefile : embed.sed generate-help.awk
	echo "# Generated file, do not edit by hand" > $@
	sed -f embed.sed generate-help.awk >> $@

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
#'
#' Please let me know if you find this project useful. Open an issue should
#' something not work as expected or should you have an enhancement idea.
#
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
