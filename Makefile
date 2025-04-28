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
	$(ASM) $(ASM_FLAGS) $(1) $(2)
endef

# $(1) - ASM file
define ASM_TO_REL
$(patsubst $(SRC_DIR)/%, $(DISt_DIR)/%, $(1:.asm=.rel))
endef

############################## CONFIG ##########################################
ASM 		:= 	./bin/asz80
ASM_FLAGS 	:= 	-o
DISt_DIR	:= 	dist/lib
ZXE_LIB 	:= 	$(DISt_DIR)/zxengine.lib
SCRIPTS_DIR := 	scripts
SRC_DIR 	:= 	zxengine/src
SRC_FILES	:= 	$(shell find $(SRC_DIR) -name '*.asm')
REL_FILES	:=	$(foreach F, $(SRC_FILES), $(call ASM_TO_REL, $(F)))
RM			:=	rm
RM_FLAGS	:=	-f

$(ZXE_LIB): $(REL_FILES)
	$(RM) $(RM_FLAGS) $@
	$(foreach f,$^,echo $f >> $@;)


# Generate all rel files.
$(foreach F, $(SRC_FILES), \
	$(eval $(call COMPILE_ASM,\
	$(call ASM_TO_REL, $(F)), $(F))\
))


install:
	@bash $(SCRIPTS_DIR)/install_asm.sh
	@bash $(SCRIPTS_DIR)/install_hex2bin.sh
	@bash $(SCRIPTS_DIR)/install_zxtaputils.sh
	$(MAKE) build

clean:
	@find $(PWD)/ -name *.rel -exec rm {} \;
	@find $(PWD)/ -name *.lib -exec rm {} \;

info:
	$(info $(REL_FILES))

.PHONY: install build clean info
