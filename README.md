Mini MEGA65 C Tutorial
======================

This repository aims to demonstrate how to compile C programs that target the
![MEGA65](https://mega65.org/) computer using any of the C tool-chains that are
currently available for that platform:
![cc65](https://cc65.github.io/),
![kickc](https://gitlab.com/camelot/kickc) and
![vbcc](http://www.compilers.de/vbcc.html).

Overview
--------

The **Makefile** contains targets for installing and updating the tool-chains
(SDK) and the MEGA65 emulator (XEMU), compiling the obligatory *hello world*
program, as well as showing how to directly run it in
![xemu](https://github.com/lgblgblgb/xemu).

This should give a starting point for experimentation and exploration, help
in gaining an overview of available options and provide a low friction entry
into cross-compiling C programs for the MEGA65.

Prerequisites
-------------

This tutorial assumes running on a *POSIX* compatible operating system and
that **java**, **git**, **curl**, **unzip**, **gcc** and **make** are available.

**Note:** Windows users may try to build using ![msys2](https://www.msys2.org/),
but will need to manually install **maven**, as well as installing **git** and
**unzip** via *pacman*.

Quick start
-----------

1) Clone repository: `git clone https://github.com/everslick/mega65-c-tutorial.git`
2) Change directory: `cd mega65-c-tutorial`
3) Install toolchains: `make sdk`
4) Install XEMU: `make xemu`
5) Compile *hello world*: `make cc65` or `make kickc` or `make vbcc`
6) Run *hello world*: `make run`
7) Clean up: `make clean`
8) `GOTO 5`

Available make targets
----------------------

* **help**   print this help
* **clean**  remove build artifacts
* **sdk**    install/update toolchains
* **xemu**   install/update xemu
* **kickc**  compile with KICKC
* **cc65**   compile and link with CC65
* **vbcc**   compile and link with VBCC
* **run**    run in Xemu

Resources
---------

Discussion & help: ![Discord](https://discord.com/channels/719326990221574164/782757495180361778)

Contributors
------------

Croccydile (testing on MSYS2, finding typos)
