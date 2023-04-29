#! /usr/bin/env sed -f
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
# embed.sed
#
# Generate the embedded version of generate-help.awk
#
# NOTE:
#
# We are making a couple of design choices here.
#
# First, we are generating code rather than maintaining separate files. This
# results in some complexity--this sed script. However, this adds clarity as
# the AWK script is easy to read and maintain as a stand alone file. Since the
# complexity of transforming the stand alone sctipt into an embedded Makefile
# recipe is somewhat small, this is a good trade-off.
#
# Second, we using sed to make the transformation. Transforming text maps
# directly to sed's strength and purpose of editing text streams. However, sed
# does present a few trade-offs:
#
#   1. sed does not scale. Since we are able to describe the code
#      transformations in three blocks of code (one of which is trivial), we
#      do not run into the scaling limitation.
#
#   2. sed syntax is very terse. To mitigate against this limitation, the
#      comments in this file are overly verbose.
#
# We have to meet the following requirements in the transformation process:
#
#   1. Begin with the Makefile target and call awk.
#
#   2. Transform the AWK script to follow a Makefile recipe quoting and
#      indentation rules.
#
#   3. End by passing the Makefile to AWK as the file argument.
#
#   4. Remove special comments that only make sense in the context of the
#      stand alone AWK file. Examples include the sha-bang (#!) and modeline
#      (vim: sts=8). We define special comments as comments that start `##`,
#      `#-`, or `#!`.
#
# Meeting the last requirements requires us to use a somewhat advanced sed
# feature, the hold buffer. The approach is as follows:
#
#    1. Transform and append to the hold buffer all non-special comment lines
#
#    2. Place the hold buffer into the pattern buffer on the last line and
#       remove the leading newline character.
#
#    3. Delete lines to prevent auto-printing.
#
#
# © 2023 Andrew Stryker <axs@sdf.org>
#
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#

#-----------------------------------------------------------------------------#
#
# Transform the script for Makefile embedding
#
# Apply the following transformations to non-special comment lines:
#   1. Escape single quote marks on non-comment lines
#   2. Insert a tab before recipe commands
#   3. Escape the end of line
#
# Finally, append the transformed pattern buffer to the hold buffer.
#
#-----------------------------------------------------------------------------#

/^#[#-\!]/! {
/^#/!s/'/\\'/g
s/^/	/
s/$/\\/
H
}

#-----------------------------------------------------------------------------#
#
# Write the embedded help target and recipe
#
# At the end of the input stream:
#   1. Insert the help target and recipe start
#   2. Place the hold buffer into the pattern buffer
#   3. Remove the leading new line character
#   4. Print the hold buffer
#   5. Close the embedded script and supply the target file
#
#-----------------------------------------------------------------------------#

$ {
i\
.PHONY: help
i\
help: #' Generate this help message
i\
\t@awk ' \\
g
s/^\n//
p
i\
\t' ${MAKEFILE_LIST}
}

#-----------------------------------------------------------------------------#
#
# Suppress auto-printing
#
# sed automatically prints all input. We do not want this as we controlled the
# output in the previous block. We can disable auto printing by requiring the
# user to call with the -n flag. A different method is to delete the pattern
# space. We take the latter approach as this imposes less burden on users.
#
#-----------------------------------------------------------------------------#

d

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
