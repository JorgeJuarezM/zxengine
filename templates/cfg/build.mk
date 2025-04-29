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

################################## VARIABLES ###################################
GAME		:= 	game.tap
ZXE_HOME	:= 	${HOME}/.zxengine
ASM			:=	$(ZXE_HOME)/bin/asz80
ASM_FLAGS 	:= 	-o


H2B			:=	$(ZXE_HOME)/bin/hex2bin
B2T			:=	$(ZXE_HOME)/bin/bin2tap
B2T_FLAGS	:=	-b  -c 32767 -r 32768 -cb 7 -cp 7 -ci 0
SRC_DIR		:=	src
OBJ_DIR		:=	obj
SRC_FILES	:=	$(shell find $(SRC_DIR) -name '*.asm')
REL_FILES	:=	$(foreach F, $(SRC_FILES),$(call ASM_TO_REL,$(F)))
GAME_IHX	:= 	$(OBJ_DIR)/game.ihx
LIBS		:=	zxengine.lib
LIBS_DIR	:=	$(abspath $(lastword $(dir $(MAKEFILE_LIST))))/../../dist/

LNK			:=	$(ZXE_HOME)/bin/aslink
LNK_FLAGS	:=	-o -b _CODE=0x8000 -k $(LIBS_DIR) -l $(LIBS)

$(GAME): $(GAME_IHX)
	$(B2T) $(B2T_FLAGS) -o $(GAME) $(GAME_IHX)

$(GAME_IHX): $(REL_FILES)
	$(LNK) $(LNK_FLAGS) -i $(GAME_IHX) $(REL_FILES)

# Generate all rel files.
$(foreach F, $(SRC_FILES), \
	$(eval $(call COMPILE_ASM,\
	$(call ASM_TO_REL, $(F)), $(F))\
))


build:
	mkdir -p $(OBJ_DIR)
	$(ASM) -o $(OBJ_DIR)/main src/main.asm
	$(LNK) -b _CODE=0x8000 -o -k $(ZXENGINE_HOME)/dist/ -l zxengine.lib -i $(OBJ_DIR)/main.ihx $(OBJ_DIR)/main.rel
	$(H2B) $(OBJ_DIR)/main.ihx
	$(B2T) $(B2T_FLAGS) -o game.tap $(OBJ_DIR)/main.bin

clean:
	find $(OBJ_DIR) -name '*.rel' -delete
	find $(OBJ_DIR) -name '*.ihx' -delete

info:
	$(info $(LIBS_DIR))