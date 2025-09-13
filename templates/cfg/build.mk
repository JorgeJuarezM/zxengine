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
	@mkdir -p $(dir $(1))
	$(ASM) $(ASM_FLAGS) $(1) $(2)
endef

# $(1) - ASM file
define ASM_TO_REL
$(patsubst $(SRC_DIR)/%,$(OBJ_DIR)/%,$(1:.asm=.rel))
endef

# $(1) - NOI file
define GET_MAIN_ADDR
$(shell grep -E '^DEF[[:space:]]+_main[[:space:]]' $(1) | awk '{print $$3}')
endef

# $(1) - NOI file
define GET_MAIN_ADDR_DEC
$(shell printf '%d' $(call GET_MAIN_ADDR, $(1)))
endef

# $(1) - NOI file
define GET_NEXT_MAIN_ADDR_DEC
$(shell echo $$(( $(call GET_MAIN_ADDR_DEC, $(1)) - 1 )))
endef

################################################################################

THIS_FILE 	:= 	$(dir $(lastword $(MAKEFILE_LIST)))

################################## VARIABLES ###################################

include 	$(THIS_FILE)global_vars.mk

GAME_NAME	?= 	game

OBJ_DIR		:=	obj
GAME_TAP	:= 	$(GAME_NAME).tap
GAME_BIN	:=	$(OBJ_DIR)/$(GAME_NAME).bin
GAME_IHX	:= 	$(OBJ_DIR)/$(GAME_NAME).ihx
GAME_NOI	:= 	$(OBJ_DIR)/$(GAME_NAME).noi

SRC_DIR		:=	src
SRC_FILES	:=	$(shell find $(SRC_DIR) -iname '*.asm')
REL_FILES	:=	$(foreach F, $(SRC_FILES),$(call ASM_TO_REL,$(F)))

LIBS		:=	$(ZXE_LIB)
LIBS_DIR	:=	$(ZXE_HOME)/lib/

CODE_START	?=	0x8000

# Border color	(white)
CB			:=	7
# Paper color	(white)
CP			:=	7
# Ink color		(black)
CI			:=	0

# asz80
ASM			:=	$(ZXE_HOME)/bin/asz80
ASM_FLAGS 	:= 	-o

# aslink
LNK			:=	$(ZXE_HOME)/bin/aslink
LNK_FLAGS	:=	-j -o -b _CODE=$(CODE_START) -k $(LIBS_DIR) -l $(LIBS)

# hex2bin
H2B			:=	$(ZXE_HOME)/bin/hex2bin
H2B_FLAGS	:=	-p 0x00
# bin2tap
B2T			:=	$(ZXE_HOME)/bin/bin2tap
B2T_FLAGS	:=	-b -cb $(CB) -cp $(CP) -ci $(CI) -o $(GAME_TAP)


$(GAME_TAP): $(GAME_IHX) $(GAME_NOI)
	$(eval PROG_START := $(call GET_MAIN_ADDR_DEC, $(GAME_NOI)))
	$(eval CLR_ADDR := $(call GET_NEXT_MAIN_ADDR_DEC, $(GAME_NOI)))

	$(H2B) $(H2B_FLAGS) $(GAME_IHX)
	$(B2T) $(B2T_FLAGS) -r $(PROG_START) -c $(CLR_ADDR) $(GAME_BIN)


$(GAME_IHX): $(REL_FILES)
	$(LNK) $(LNK_FLAGS) -i $(GAME_IHX) $(REL_FILES)

# Generate all rel files.
$(foreach F, $(SRC_FILES), \
	$(eval $(call COMPILE_ASM,\
	$(call ASM_TO_REL, $(F)), $(F))\
))

clean:
	@find $(OBJ_DIR) -name '*.rel' -delete
	@find $(OBJ_DIR) -name '*.ihx' -delete
	@find $(OBJ_DIR) -name '*.map' -delete
	@find $(OBJ_DIR) -name '*.noi' -delete
	@find $(OBJ_DIR) -name '*.bin' -delete

info:
	$(info $(THIS_FILE))

.PHONY: clean info