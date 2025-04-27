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
DIST_LIB_DIR := dist/lib
SOURCE_CODE_DIRS := zxengine/src
SOURCE_CODE_FILES := $(foreach dir,$(SOURCE_CODE_DIRS),$(wildcard $(dir)/*.asm))
SCRIPTS_DIR := scripts

.PHONY: build

install:
	@bash $(SCRIPTS_DIR)/install_asm.sh
	@bash $(SCRIPTS_DIR)/install_hex2bin.sh
	@bash $(SCRIPTS_DIR)/install_zxtaputils.sh
	$(MAKE) build

build:
	$(foreach file,$(SOURCE_CODE_FILES), \
		$(ASM) -o $(DIST_LIB_DIR)/$(notdir \
			$(file:.asm=.rel)) $(file); \
	)
	find $(PWD)/dist/lib/ -name *.rel > dist/main.lib

clean:
	find $(PWD)/ -name *.rel -exec rm {} \;
	find $(PWD)/ -name *.lib -exec rm {} \;
