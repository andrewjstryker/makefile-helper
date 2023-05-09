# Demonstration

```
curl -LO https://raw.githubusercontent.com/andrewjstryker/makefile-helper/main/generate-help.awk

cat > Makefile << EOF
#> Project name
#>
#> Concise project the description
#>
#> Elaboration as needed
#>
# Other information, copyright, etc...

.PHONY: build install help

build: blah #> Build the project (default)
	# build recipe

install: build #! Install to system
	# install recipe

help: #> Display this message
	@awk -f generate-help.awk $(MAKEFILE_LIST)
EOF

make help
```

# Use Cases

1. You are new to a project and need to familiarize yourself with the build
   tools and project structure.

2. You are a developer that wants to document how newcomers should interact
   with the build system for project and wants to minimize the effort required
   to keep documentation current.
