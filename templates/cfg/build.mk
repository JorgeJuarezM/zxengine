# -----------------------------LICENSE NOTICE-----------------------------------
#  This file is part of ZXEngine https://github.com/JorgeJuarezM/zxengine
#  Copyright (C) 2025  Jorge Luis Juárez Mandujano (@JorgeJuarezM)

#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.

#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.

#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <https://www.gnu.org/licenses/>.
# ------------------------------------------------------------------------------
############################## MACROS ##########################################
#	$(1) - Target
#	$(2) - Source
define COMPILE_ASM
$(1): $(2)
	mkdir -p $(dir $(1))
	$(ASM) $(ASM_FLAGS) $(1) $(2)
endef

# $(1) - ASM file
define ASM_TO_REL
$(patsubst $(SRC_DIR)/%,$(OBJ_DIR)/%,$(1:.asm=.rel))
endef

################################################################################

THIS_FILE 	:= 	$(dir $(lastword $(MAKEFILE_LIST)))

################################## VARIABLES ###################################

include 	$(THIS_FILE)global_vars.mk

GAME		:= 	game.tap
GAME_BIN	:=	game.bin
GAME_IHX	:= 	game.ihx

SRC_DIR		:=	src
OBJ_DIR		:=	obj
SRC_FILES	:=	$(shell find $(SRC_DIR) -iname '*.asm')
REL_FILES	:=	$(foreach F, $(SRC_FILES),$(call ASM_TO_REL,$(F)))

LIBS		:=	$(ZXE_LIB)
LIBS_DIR	:=	$(ZXE_HOME)/lib/

CODE_START	:=	0x8000
PROG_START	:=	32768
CLR_START	:=	32767

CB			:=	7		# Border color	(white)
CP			:=	7		# Paper color	(white)
CI			:=	0		# Ink color		(black)

# asz80
ASM			:=	$(ZXE_HOME)/bin/asz80
ASM_FLAGS 	:= 	-o

# aslink
LNK			:=	$(ZXE_HOME)/bin/aslink
LNK_FLAGS	:=	-o -b _CODE=$(CODE_START) -k $(LIBS_DIR) -l $(LIBS)

# hex2bin
H2B			:=	$(ZXE_HOME)/bin/hex2bin

# bin2tap
B2T			:=	$(ZXE_HOME)/bin/bin2tap
B2T_FLAGS	:=	-b  -c $(CLR_START) -r $(PROG_START) \
				-cb $(CB) -cp $(CP) -ci $(CI)


$(GAME): $(OBJ_DIR)/$(GAME_IHX)
	$(H2B) $(H2B_FLAGS) $(OBJ_DIR)/$(GAME_IHX)
	$(B2T) $(B2T_FLAGS) -o $(GAME) $(OBJ_DIR)/$(GAME_BIN)


$(OBJ_DIR)/$(GAME_IHX): $(REL_FILES)
	$(LNK) $(LNK_FLAGS) -i $(OBJ_DIR)/$(GAME_IHX) $(REL_FILES)

# Generate all rel files.
$(foreach F, $(SRC_FILES), \
	$(eval $(call COMPILE_ASM,\
	$(call ASM_TO_REL, $(F)), $(F))\
))

clean:
	find $(OBJ_DIR) -name '*.rel' -delete
	find $(OBJ_DIR) -name '*.ihx' -delete
	find $(OBJ_DIR) -name '*.bin' -delete

info:
	$(info $(THIS_FILE))