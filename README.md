# `Makefile` help generator

Create a help message from a self-documented `Makefile`

A `Makefile` can grow in complexity and require its own documentation. That
often takes the form an `INSTALL` file. That can also adds to the effort
required to use the build system and leads developers abandoning the
conventional `Makefile` in favor of other build systems. This project provides
an alternative approach. This approach allows developers to write documentation
directly into a `Makefile` as shown below:

<!--
    insert screen capture here
-->

<!--
    TOC
-->

## Usage

As shown in the above animation, usage from the user's view point is `make
help`.

## Writing a `Makefile` for `generate-help.awk`

`generate-help.awk` applies the following mutually exclusive rules to generate
a help message:

1. Place lines beginning with `#'` into the help message, after stripping the
   leading `#'` plus up to one space.

2. Transform lines with a leading tab character, `#`, and zero or one spaces by
   placing only the text after the `#'` and up to one space into the help
   message. E.g., `	#' text for help message`.

3. Split target lines at `#'`. The first field is the target and the second
   field is the help message.

4. Split target lines at `#!`. The first field is a target that _might_ require
   `sudo` and the second field is the help message.

5. Check for `sudo` targets at exit and print a notice if some where
   encountered.

<!--

## Incorporating into to a `Makefile`

```sh
Part of the generated help message
```

-->

## Limitations

This is project aspires to be very light-weight. In essence, the code in the
project boils down to a small number of AWK commands. As a result, there are a
few limitations:

  * No formatting or line wrapping. While that is an approach that could be
    feasible (see `fmt(1)`), doing so would add an additional layer of
    complexity. The goal is to keep things simple.

  * Does not work with [grouped
    targets](https://www.gnu.org/software/make/manual/html_node/Multiple-Targets.html).
    This is a bit of a corner case. One approach is to place the grouped target
    behind a `.PHONY` target. Then, document the abstraction.

  * Lacks logic for handling multiple `#'` character sequences on a target
    line. If you do this, you are not really following the usage guidelines.

  * Lacks visibility into the terminal background. If someone has a cyan or red
    background, the targets will not be visible. 

## Installation

There are a few ways to install this project:

  * Copy `generate-help.awk` to your own project. This is probably the best
    option for nearly all use cases. You will miss any updates or new releases.
    Given that one project goal is to keep things as simple as possible, this
    is not a big risk.

  * Clone the project as a `git`
    [submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules). This is
    totally possible, though this approach introduces a bit of complexity into
    the main project repository.

  * Embed in to the project `Makefile`. Using this code as a reference and
    embedding it directly into the `help` recipe is a completely valid
    approach. You will benefit from having one fewer file in your project. Just
    be careful about following the `Makefile` quotation and line continuation
    rules.

## Motivation

Having to read an `INSTALL` file to build a project is a sign that a project
has a problem. Namely, building the project requires specialized knowledge and
a series of commands. That's way too much unnecessary friction, especially for
someone new to a project. Further, there is nothing that forces a developer to
update an `INSTALL` file should the build system change. Ideally, a user can
invoke a command to build the project and not worry about the underlying tool
chain. Further, the user can quickly get help about other tasks (such as
building documentation).

The `Makefile` is the traditional interface between programmers and the build
system. They are also very general in that they understand targets,
dependencies, and recipes. This paradigm covers a lot of ground.

The author of this project has observed the following

  1. Placing develop tasks in a `Makefile` simplifies development, regardless of
     the underlying tool chain.

  2. Requiring a user to invoke `make` is asking users to follow conventions
     that have worked since the 1970s.

  3. Keeping documentation close to code increases the odds of good, current
     documentation.

  4. Providing build instructions via `make help` helps both users and
     developers.

<!--
    Collaborating
-->
