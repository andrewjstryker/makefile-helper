#! /usr/bin/env awk -f
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#
## generate-help.awk
##
# Makefile help generator
# https://github.com/andrewjstryker/makefile-helper
##
##
## ANSI color codes:
## clear = "\033[0m"
## cyan = "\036[0m"
## red = "\031[0m"
##
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-#

BEGIN {
        # split fields from colon to either #' or #!
        FS = ":.*#['!]"

        # track if any targets require special privileges
        special = 0
}

# full length help message
/^#'/ {
        printf("%s\n", gensub(/^#' ?(.*)$/, "\\1", "g", $0))
        next
}

# continuation messages
/^\t#'/ {
        printf("\t%17s%s\n",
               " ",
               gensub(/^\t#' ?(.*)$/, "\\1", "g", $0))
        next
}

# targets that might require elevated priveleges
/^[a-zA-Z_]+\s*:.*#!/ {
        printf("\t\033[31m%-15s\033[0m %s\n", $1, $2)
        special = 1
        next
}

# normal targets
/^[a-zA-Z_]+\s*:.*#'/ {
        printf("\t\033[36m%-15s\033[0m %s\n", $1, $2)
        next
}

END {
        if (special) {
                printf("\nTargets in \033[31mred\033[0m ")
                printf("might require special priveleges.\n")
        }
}

## vim: et sts=8
