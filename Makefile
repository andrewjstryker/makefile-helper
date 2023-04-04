#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
#
#' Example Makefile that is compatible with generate-help.awk
#'
#' This Makefile simplifies porting configuration to new systems.
#'
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#

#-----------------------------------------------------------------------------#
#
# User friendly targets
#
#-----------------------------------------------------------------------------#

.PHONY: default all make clean install help

# define the default target explictly
default: all # Notice that a regular comment, such as these ones, will not
	# appear in the generated help message

all: embed #' Generate all derived files (currently only embed)

embed: help-target.makefile #' Generate the embeddable target and recipe

install: generate-help.awk #! Install this file to the system
	install generate-help.awk /usr/local/bin

clean: #' Remove generated files
	rm -f help-target.makefile

help: #' Generate this help message
	@# beginning a command with '@' prevents Make from echoing
	@awk -f generate-help.awk $(MAKEFILE_LIST)

#-----------------------------------------------------------------------------#
#
# System targets
#
#-----------------------------------------------------------------------------#

help-target.makefile: embed.sed generate-help.awk
	echo "# Generated file, do not edit by hand" > $@
	sed -f embed.sed generate-help.awk >> $@

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
#'
#' Please let me know if you find this project useful. Open an issue should
#' something not work as expected or should you have an enhancement idea.
#
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
