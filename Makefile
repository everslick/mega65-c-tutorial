VERSION  = 0.0.1

ifeq ($(PRG),)
PRG      = 01
endif

SDKDIR   = ..
PROGRAM  = prg-$(PRG)
SOURCES  = prg-$(PRG).c
TARGET   = $(PROGRAM).prg
sources  = $(wildcard *.c)

ifeq ($(SDK),)
SDK      = gcc
TARGET   = $(PROGRAM)
endif

ifeq ($(SDK),cc65)
CC       = cl65
CFLAGS   = -t c64 --create-dep $(<:.c=.d) -O -Or -Oi -Os --cpu 65c02
LDFLAGS  = -m $(PROGRAM).map -C vicii.cfg
endif

ifeq ($(SDK),kickc)
CFLAGS   = -a -Sc -Si -Wfragment
endif

ifeq ($(SDK),vbcc)
CFLAGS   = +m65sr -v -O3
endif

DEFINES  = -DVERSION=$(VERSION) -DPROGRAM=$(PROGRAM) -DTOOLCHAIN=$(SDK)

########################################

RED = '\033[0;31m'
GRN = '\033[0;32m'
CYN = '\033[0;36m'
YEL = '\033[1;33m'
RST = '\033[0m' # No Color

SHELL = bash

########################################

export VBCC=$(SDKDIR)/vbcc6502/vbcc6502_linux/vbcc/
export CC65_HOME=$(SDKDIR)/cc65

export PATH=$(VBCC)/bin:$(CC65_HOME)/bin:$(SDKDIR)/xemu/build/bin:$(SDKDIR)/kickc/bin:$(shell echo $$PATH)

########################################

.SUFFIXES:
.PHONY: all clean run help xemu sdk

all: $(PROGRAM)

########################################

help:
	@echo
	@echo "supported make targets are:"
	@echo
	@echo "\thelp   print this help"
	@echo "\tsetup  install/update tool-chains and Xemu"
	@echo "\tkickc  compile with KICKC"
	@echo "\tcc65   compile and link with CC65"
	@echo "\tvbcc   compile and link with VBCC"
	@echo "\tclean  remove build artifacts"
	@echo

cc65:
	$(MAKE) SDK=cc65 MACHINE=m65
	$(MAKE) run

kickc:
	$(MAKE) SDK=kickc MACHINE=m65 run-kickc
	$(MAKE) run

vbcc:
	$(MAKE) SDK=vbcc MACHINE=m65 run-vbcc
	$(MAKE) run

run-kickc:
	kickc.sh -p mega65 $(CFLAGS) $(DEFINES) -o $(TARGET) $(SOURCES)

run-vbcc:
	vc $(CFLAGS) $(DEFINES) -o $(TARGET) $(SOURCES)

run:
	chmod +x $(PROGRAM).prg
	xmega65.native -besure -prg $(PROGRAM).prg
	$(MAKE) clean

clean:
	$(RM) *.o *.d *.map *.asm *.dbg *.vs *.klog *.prg $(PROGRAM)

setup:
	@echo -e ${YEL}Pulling in SDK ...${RST}
	@if [ -d $(SDKDIR)/xemu ] ; then                                       \
	  echo -e ${CYN}Updating ${RED}XEMU${CYN} ... ${RST} ;                 \
	  cd $(SDKDIR)/xemu ;                                                  \
	  OUT=`git pull` ;                                                     \
	  if [ "$$OUT" != "Already up to date." ] ; then make ; fi ;           \
	else                                                                   \
	  echo -e ${CYN}Installing ${RED}XEMU${CYN} ... ${RST} ;               \
	  cd $(SDKDIR) ;                                                       \
	  git clone https://github.com/lgblgblgb/xemu.git ;                    \
	  cd xemu ;                                                            \
	  make ;                                                               \
	fi ;
	@if [ -d $(SDKDIR)/cc65 ] ; then                                       \
	  echo -e ${CYN}Updating ${RED}CC65${CYN} ... ${RST} ;                 \
	  cd $(SDKDIR)/cc65 ;                                                  \
	  OUT=`git pull` ;                                                     \
	  if [ "$$OUT" != "Already up to date." ] ; then make ; fi ;           \
	else                                                                   \
	  echo -e ${CYN}Installing ${RED}CC65${CYN} ... ${RST} ;               \
	  cd $(SDKDIR) ;                                                       \
	  git clone https://github.com/cc65/cc65.git ;                         \
	  cd cc65 ;                                                            \
	  make ;                                                               \
	fi ;
	@if [ -d $(SDKDIR)/kickc-src ] ; then                                  \
	  echo -e ${CYN}Updating ${RED}KICKC${CYN} ... ${RST} ;                \
	  cd $(SDKDIR)/kickc-src ;                                             \
	  OUT=`git pull` ;                                                     \
	  if [ "$$OUT" != "Already up to date." ] ; then make ; fi ;           \
	  cd .. ;                                                              \
	  rm -rf kickc ;                                                       \
	  tar xf kickc-src/target/kickc-release.tgz ;                          \
	else                                                                   \
	  echo -e ${CYN}Installing ${RED}KICKC${CYN} ... ${RST} ;              \
	  cd $(SDKDIR) ;                                                       \
	  git clone https://gitlab.com/camelot/kickc.git kickc-src ;           \
	  cd kickc-src ;                                                       \
	  make ;                                                               \
	  cd .. ;                                                              \
	  rm -rf kickc ;                                                       \
	  tar xf kickc-src/target/kickc-release.tgz ;                          \
	fi ;
	@if [ ! -d $(SDKDIR)/vbcc6502 ] ; then                                 \
	  echo -e ${CYN}Installing ${RED}VBCC${CYN} ... ${RST} ;               \
	  cd $(SDKDIR) ;                                                       \
		curl http://www.ibaug.de/vbcc/vbcc6502_r3p1.zip --output vbcc.zip ;  \
		unzip vbcc.zip ;                                                     \
		rm vbcc.zip ;                                                        \
	fi ;
	@echo -e ${GRN}DONE pulling in SDK${RST}

########################################

ifneq ($(MAKECMDGOALS),clean)
-include $(SOURCES:.c=.d)
endif

%.o: %.c
	$(CC) -c $(CFLAGS) $(DEFINES) -o $@ $<

$(PROGRAM): $(SOURCES:.c=.o)
	$(CC) $(LDFLAGS) -o $(TARGET) $^
