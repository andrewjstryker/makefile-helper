#! /usr/bin/env awk -f
#
## ANSI color codes:
# clear = "\033[0m"
# cyan = "\036[0m"
# red = "\031[0m"

BEGIN {
        # split fields from colon to either #' or #!
        FS = ":.*#['!]"

        # track if any targets require sudo privileges
        sudo = 0
}

# full length help message
/^#'/ {
        # TODO: ensure compatible with BSD Awk
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
        sudo = 1
        next
}

# normal targets
/^[a-zA-Z_]+\s*:.*#'/ {
        printf("\t\033[36m%-15s\033[0m %s\n", $1, $2)
}

END {
        if (sudo) {
                printf("\nTargets in \033[31mred\033[0m might require sudo.\n")
        }
}

# vim: et sts=8
