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

build:
	$(ASM) -l -o main src/main.asm
	$(LNK) -n -u -b _CODE=0x8000 -o -k $(ZXENGINE_HOME)/dist/ -l zxengine.lib -i main.ihx main.rel
	hex2bin main.ihx
	tapify --startaddr 32768 main.bin main.tmp.tap
	bas2tap --autostart 10 $(ZXENGINE_HOME)/templates/basic/loader.bas loader.tmp.tap
	cat loader.tmp.tap main.tmp.tap > game.tap
	
	# /Applications/zesarux.app/Contents/MacOS/zesarux $(PWD)/game.tap

clean:
	rm -f *.tmp.tap
	rm -f *.bin
	rm -f *.ihx
	rm -f *.rel
	rm -f *.hlr
	rm -f *.lst
	rm -f *.rst
