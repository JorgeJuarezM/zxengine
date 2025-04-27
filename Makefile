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
ASM := ./bin/asz80
SCRIPTS_DIR := scripts
DIST_LIB_DIR := dist/lib
ZXE_LIB := $(DIST_LIB_DIR)/zxengine.lib
SOURCE_CODE_DIRS := zxengine/src
SOURCE_CODE_FILES := $(shell find $(SOURCE_CODE_DIRS) -name '*.asm')
TARGET_FILES := $(subst $(SOURCE_CODE_DIRS), \
					$(DIST_LIB_DIR), \
					$(SOURCE_CODE_FILES:%.asm=%.rel))


$(DIST_LIB_DIR)/%.rel: $(addprefix $(SOURCE_CODE_DIRS)/, %.asm)
	$(shell mkdir -p $(dir $@))
	$(shell $(ASM) -o $@ $<)

$(ZXE_LIB): $(TARGET_FILES)
	@find $(DIST_LIB_DIR) -name *.rel > dist/zxengine.lib

install:
	@bash $(SCRIPTS_DIR)/install_asm.sh
	@bash $(SCRIPTS_DIR)/install_hex2bin.sh
	@bash $(SCRIPTS_DIR)/install_zxtaputils.sh
	$(MAKE) build

build: $(TARGET_FILES) $(ZXE_LIB)

clean:
	@find $(PWD)/ -name *.rel -exec rm {} \;
	@find $(PWD)/ -name *.lib -exec rm {} \;

.PHONY: install build clean
