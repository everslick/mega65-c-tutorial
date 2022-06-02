Mini MEGA65 C Tutorial
======================

This repository aims to demonstrate how you can build C programs that target
the ![MEGA65](https://mega65.org/) computer using any of the C compilers that
are currently available for that platform:
![cc65](https://cc65.github.io/),
![kickc](https://gitlab.com/camelot/kickc) and
![vbcc](http://www.compilers.de/vbcc.html).

Purpose:
--------

The **Makefile** contains targets for installing and updating the compilers
(SDK) and an emulator (XEMU), compiling the obligatory **hello world** program,
as well as showing how to directly run it in
![xemu](https://github.com/lgblgblgb/xemu).

It should give you a starting point for experimentation and exploration, help
you in gaining an overview of available options and provide a low friction
entry into cross compiling C programs for the MEGA65.

Prerquisits:
------------

This tutorial assumes running on a **Linux** box and that you have **java**,
**git**, **curl**, **unzip**, **gcc** and **make** installed.

The vailable make targets are:
------------------------------

* help   print this help
* clean  remove build artefacts
* sdk    install/update compilers
* xemu   install/update xemu
* kickc  compile with KICKC
* cc65   compile and link with CC65
* vbcc   compile and link with VBCC
* run    run in Xemu

Qick start:
-----------

1) Clone repository: `git clone https://github.com/everslick/mega65-c-tutorial.git)`
2) Install compilers: `make sdk`
3) Install XEMU: `make xemu`
4) Compile hello world: `make cc65` or `make kickc` or `make vbcc`
5) Run hello world: `make run`
6) Clean up: `make clean`

Resources:
----------

![Discord](https://discord.com/channels/719326990221574164/782757495180361778)

