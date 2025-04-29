# ---------------------------- LICENSE NOTICE ----------------------------------
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
$(patsubst $(SRC_DIR)/%, $(DIST_DIR)/%, $(1:.asm=.rel))
endef

############################## CONFIG ##########################################
ZXE_HOME	:= 	${HOME}/.zxengine
ASM 		:= 	$(ZXE_HOME)/bin/asz80
ASM_FLAGS 	:= 	-o
DIST_DIR	:= 	dist
ZXE_LIB 	:= 	$(DIST_DIR)/zxengine.lib
SCRIPTS_DIR := 	scripts
SRC_DIR 	:= 	zxengine/src
SRC_FILES	:= 	$(shell find $(SRC_DIR) -name '*.asm')
REL_FILES	:=	$(foreach F, $(SRC_FILES), $(call ASM_TO_REL, $(F)))
RM			:=	rm
RM_FLAGS	:=	-f
MKDIR		:=	mkdir -p
BIN_DIR		:=	$(ZXE_HOME)/bin
ALL_DIRS	:=	$(ZXE_HOME) $(BIN_DIR)

$(ZXE_LIB): $(ZXE_HOME) $(REL_FILES)
	$(RM) $(RM_FLAGS) $@
	$(foreach f, $(REL_FILES), echo $(subst $(DIST_DIR)/,,$(f)) >> $@;)


# Generate all rel files.
$(foreach F, $(SRC_FILES), \
	$(eval $(call COMPILE_ASM,\
	$(call ASM_TO_REL, $(F)), $(F))\
))


$(ALL_DIRS):
	$(MKDIR) $(ALL_DIRS)

install:
	$(MAKE) -C zxengine/tools/asxxxx OUT_DIR=$(ZXE_HOME)/bin
	$(MAKE) -C zxengine/tools/hex2bin OUT_DIR=$(ZXE_HOME)/bin
	$(MAKE) -C zxengine/tools/bin2tap OUT_DIR=$(ZXE_HOME)/bin

clean:
	@find $(PWD)/ -name *.rel -exec rm {} \;
	@find $(PWD)/ -name *.lib -exec rm {} \;

info:
	$(info $(ZXE_HOME))
	$(info $(HOME))


build: $(ALL_DIRS)


.PHONY: install build clean info
