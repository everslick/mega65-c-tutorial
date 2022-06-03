MEGA65 C Tutorial
=================

This repository aims to demonstrate how to compile C programs that target the
![MEGA65](https://mega65.org/) computer using any of the C tool-chains that are
currently available for that platform:
![cc65](https://cc65.github.io/),
![kickc](https://gitlab.com/camelot/kickc) and
![vbcc](http://www.compilers.de/vbcc.html).

Overview
--------

The **Makefile** contains targets for installing and updating the tool-chains
(SDK) and the MEGA65 emulator (XEMU), compiling the example programs (one at a
time), as well as running them in ![Xemu](https://github.com/lgblgblgb/xemu).

This should give a starting point for experimentation and exploration, help
in gaining an overview of available options and provide a low friction entry
into cross-compiling C programs for the MEGA65.

Prerequisites
-------------

This tutorial assumes running on a *POSIX* compatible operating system and
that **java**, **git**, **curl**, **unzip**, **gcc** and **make** are available.

**Note:** Windows users may try to build using ![msys2](https://www.msys2.org/),
but will need to manually install **maven** (get the
[zip archive](https://maven.apache.org/download.cgi) and unpacked it directly
into */usr/local* of your msys2 installation), as well as installing **SDL2**,
**git** and **unzip** via *pacman* (something like
`pacman -S mingw-w64-x86_64-SDL2 unzip git` might do the trick here.
Additionally it might be necessary to add the location of the (locally
installed) **java** runtime to the **PATH** variable with something like:
`export PATH=/c/path/to/your/jdk/bin:$PATH` in *\~/.bash_profile*. YMMV, though.

Quick start
-----------

1) Clone repository: `git clone https://github.com/everslick/mega65-c-tutorial.git`
2) Change directory: `cd mega65-c-tutorial`
3) Install tool-chains and Xemu: `make setup`
4) Compile and run *hello world*: `make cc65` or `make kickc` or `make vbcc`
5) `GOTO 4`

Usage
-----

So how does this tutorial work anyway? Each *lesson* tries to focus on one
specific issue or feature and is accompanied by an example program that must be
compiled with `make PRG=XX YYY` where `XX` is a two digit number (e.g. `05`)
and `YYY` is the compiler you want the program to be built with (e.g. `cc65`).

If the build was successful, Xemu will be started automatically and the program
will be injected and launched in Xemu. When you close the Xemu window the
program binary and all its build artifacts (like object files and similar) get
deleted and you can recompile the same program with a different compiler or
compile a different program.

Examples
--------

In the following section each example program gets a short description and
compares and contrasts the differences between the compilers, as well as
possible issues with a particular tool-chain.

### Example 01 (hello world)

The simplest possible exercise most programmers try when learning a new
language: The infamous **hello, world!** program. Simple as it is, it already
demonstrates multiple issues and differences between all compilers.

Source:
```
#include <stdio.h>

int main(int argc, char **argv) {
  printf("hello, world!\n");

  return (0);
}
```

Build:
`make PRG=01 vbcc`

### Example 02 (hello world refined)

Example 02 tries to rectify the differences and issues raised in example 01 by
taking some precausions before printing to the screen.

Source:
```
#include <stdio.h>

#define _mkstr_(_s_)  #_s_
#define mkstr(_s_)    _mkstr_(_s_)

#define POKE(X,Y) (*(unsigned char *)(X))=Y
#define PEEK(X)   (*(unsigned char *)(X))

static void togglecase(void) {
#ifdef __KICKC__
  POKE(0xD018, PEEK(0xD018) ^ 0x02);
#endif
}

int main(int argc, char **argv) {
  togglecase();

  printf("hello, world!\n\n");
  printf("PROGRAM=%s, VERSION=%s, TOOLCHAIN=%s\n",
    mkstr(PROGRAM), mkstr(VERSION), mkstr(TOOLCHAIN)
  );

  return (0);
}
```

Build:
`make PRG=02 kickc`

Available make targets
----------------------

* **help**   print this help
* **clean**  remove stale build artifacts
* **setup**  install/update tool-chains and Xemu
* **kickc**  compile with KICKC
* **cc65**   compile and link with CC65
* **vbcc**   compile and link with VBCC

Resources
---------

Discussion & Help: ![Discord](https://discord.com/channels/719326990221574164/782757495180361778)

Contributors
------------

Croccydile (testing on MSYS2, finding typos)

ToDo
----

* More lessons (example programs)
* Better code documentation

Suggestions, bug reports, and pull requests are very welcome!
