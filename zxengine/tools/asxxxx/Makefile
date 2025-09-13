################################################################################
# Project  Variables
################################################################################
MKDIR_P 	=	mkdir -p
OUT_DIR 	:=	dist
################################################################################
# Compiler Variables
################################################################################
CC		=	gcc
CCOPT	=	-O3
CCFLAGS	=	-Wall -funsigned-char $(CCOPT) -Wno-deprecated-non-prototype

LD		=	gcc
LDFLAGS	=	-Wall

ASXX 	=	asdata.o asexpr.o aslex.o aslist.o	\
			asmain.o asmcro.o asout.o assubr.o	\
			assym.o	asdbg.o

ASXBAS	:=	.
SRCASX	:=	$(ASXBAS)/asxxsrc/
SRCMISC	:=	$(ASXBAS)/asxxmisc/
SRCLNK	:=	$(ASXBAS)/linksrc/

ASXXSRC =	$(addprefix $(SRCASX),$(ASXX))

################################################################################
# ASZ80 Variables
################################################################################
SRCZ80		=	$(ASXBAS)/asz80/
ASZ80 		=	z80adr.o z80mch.o z80pst.o
ASZ80SRC 	=	$(addprefix $(SRCZ80),$(ASZ80))
ASZ80_BIN	=	$(OUT_DIR)/asz80

################################################################################
# ASLINK Variables
################################################################################
ASLINK		=	lkmain.o lkhead.o lkarea.o lkbank.o	\
				lkdata.o lkeval.o lklex.o lklibr.o	\
				lklist.o lkrloc.o lkrloc3.o lkrloc4.o	\
				lksym.o lkout.o lknoice.o lksdcdb.o

ASLINKSRC	=	$(addprefix $(SRCLNK),$(ASLINK))
ASLINK_BIN	=	$(OUT_DIR)/aslink
################################################################################
# Targets
################################################################################

# Build all
all: aslink asz80

# Build asz80
$(ASZ80SRC): $(SRCMISC)alloc.h $(SRCASX)asxxxx.h $(SRCZ80)z80.h

$(ASZ80_BIN): $(ASXXSRC) $(ASZ80SRC)
	$(MKDIR_P) $(OUT_DIR)
	$(LD) $(LDFLAGS) $(ASXXSRC) $(ASZ80SRC) -o $(OUT_DIR)/asz80

# Build aslink
$(ASLINK):	$(SRCMISC)alloc.h $(SRCLNK)aslink.h

$(ASLINK_BIN): $(ASLINKSRC)
	$(MKDIR_P) $(OUT_DIR)
	$(LD) $(LDFLAGS) $(ASLINKSRC) -o $(OUT_DIR)/aslink

# Build directories
$(OUT_DIR):
	$(MKDIR_P) $(OUT_DIR)

# Build sources
%.o: %.c
	$(CC) $(CCFLAGS) -I$(SRCMISC) -I$(SRCASX) -c $< -o $@

# Build targets
asz80: 	$(ASZ80_BIN)
aslink: $(ASLINK_BIN)


# Clean object files
clean:
	find . -name "*.o" -exec rm {} \;

# Clean all (including executable files)
clean_all:
	$(MAKE) clean
	rm -rf $(OUT_DIR)

# Format code
format:
	find . -type f -name "*.c" -exec clang-format -i {} \;  
	find . -type f -name "*.h" -exec clang-format -i {} \;  


.PHONY: all clean clean_all format asz80 aslink
