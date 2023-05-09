# Use Case

1. You are new to the development team and need familiarize yourself with the
   build tools and project structure.

2. You are a developer that needs to document how newcomers should interact
   with the build system for project and wants to minimize the effort required
   to keep documentation current.

# Demonstration

```
curl -L https://raw.githubusercontent.com/andrewjstryker/makefile-helper/main/generate-help.awk

cat > Makefile <<-EOF
	#> Makefile for your awesome project
	#>
	#> Concise project the description
	#
	# Other information, copyright, etc...

	.PHONY: build install help

	build: blah #> Build the project (default)
		# build recipe

	install: build #! Install to system
		# install recipe

	help: #> Display this message
		@awk -f generate-help.awk ${MAKEFILE_LIST}
	EOF

make help
```

# Verify

1. _Helpful for newcomers?_ Yes, uses the conventional `Makefile` rather than
   requiring a newcomer to read through an `INSTALL.md` file.

2. _Helpful for a develop?_ Yes, add a file to project and annotate each
   `Makefile` target.
