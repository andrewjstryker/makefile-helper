#! /usr/bin/env sed -f
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
# embed.sed
#
# Generate the embedded version of generate-help.awk
#
#
# Andrew Stryker <axs@sdf.org>
#
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#

#-----------------------------------------------------------------------------#
#
# Transform the script for Makefile embedding
#
#   1. Escape single quote marks on non-comment lines
#   2. Insert a tab before recipe commands
#   3. Escape the end of line
#
#
# Append everything but special comments to the hold buffer
#
# We n
# We are using sed's "hold" buffer so that we are guarented to pro
# Not all of the comments in AWK file add value in the embedded script.
#
# Additionally, we skip lines that start with `##`, `#-`, and `#!`. This
# allows us to be more verbose in the stand alone AWK script and more compact
# in the embedded version.
#
#-----------------------------------------------------------------------------#

#-----------------------------------------------------------------------------#

/^#[#-\!]/! {
/^[^#]/s/'/\\'/g
s/^/	/
s/$/\\/
H
}

#-----------------------------------------------------------------------------#

#-----------------------------------------------------------------------------#
#
# Write the embedded help target and recipe
#
#   1. Insert the help target and recipe start
#   2. Print the hold buffer
#   3. Close the embedded script
#
#-----------------------------------------------------------------------------#

$ {
i\
.PHONY : help
i\
help: #' Generate this help message
i\
\tawk ' \\
g
s/^\n//
p
i\
\t' ${MAKEFILE_LIST}
}

#-----------------------------------------------------------------------------#

d

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
