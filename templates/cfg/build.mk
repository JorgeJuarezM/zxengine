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
ZXE_HOME	:= 	${HOME}/.zxengine
ASM			:=	$(ZXE_HOME)/bin/asz80
LNK			:=	$(ZXE_HOME)/bin/aslink
H2B			:=	$(ZXE_HOME)/bin/hex2bin
B2T			:=	$(ZXE_HOME)/bin/bin2tap
B2T_FLAGS	:=	-b  -c 32767 -r 32768 -cb 7 -cp 7 -ci 0
DIR_OBJ		:=	obj

build:
	mkdir -p $(DIR_OBJ)
	$(ASM) -o $(DIR_OBJ)/main src/main.asm
	$(LNK) -b _CODE=0x8000 -o -k $(ZXENGINE_HOME)/dist/ -l zxengine.lib -i $(DIR_OBJ)/main.ihx $(DIR_OBJ)/main.rel
	$(H2B) $(DIR_OBJ)/main.ihx
	$(B2T) $(B2T_FLAGS) -o game.tap $(DIR_OBJ)/main.bin

clean:
	rm -f *.tap
	rm -f *.bin
	rm -f *.ihx
	rm -f *.rel
	rm -f *.hlr
	rm -f *.lst
	rm -f *.rst
