# Generated file, do not edit by hand
.PHONY : help
help : #' Generate this help message
	awk ' \
	# Makefile help generator\
	# https://github.com/andrewjstryker/makefile-helper\
	\
	BEGIN {\
	        # split fields from colon to either #\' or #!\
	        FS = ":.*#[\'!]"\
	\
	        # track if any targets require sudo privileges\
	        sudo = 0\
	}\
	\
	# full length help message\
	/^#\'/ {\
	        printf("%s\n", gensub(/^#\' ?(.*)$/, "\\1", "g", $0))\
	        next\
	}\
	\
	# continuation messages\
	/^\t#\'/ {\
	        printf("\t%17s%s\n",\
	               " ",\
	               gensub(/^\t#\' ?(.*)$/, "\\1", "g", $0))\
	        next\
	}\
	\
	# targets that might require elevated priveleges\
	/^[a-zA-Z_]+\s*:.*#!/ {\
	        printf("\t\033[31m%-15s\033[0m %s\n", $1, $2)\
	        sudo = 1\
	        next\
	}\
	\
	# normal targets\
	/^[a-zA-Z_]+\s*:.*#\'/ {\
	        printf("\t\033[36m%-15s\033[0m %s\n", $1, $2)\
	        next\
	}\
	\
	END {\
	        if (sudo) {\
	                printf("\nTargets in \033[31mred\033[0m ")\
	                printf("might require sudo.\n")\
	        }\
	}\
	\
	' ${MAKEFILE_LIST}
