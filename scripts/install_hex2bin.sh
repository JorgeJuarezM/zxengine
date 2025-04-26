#!/usr/bin/env bash
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
if [ ! -f hex2bin.zip ]; then
    wget https://github.com/algodesigner/hex2bin/archive/refs/heads/master.zip -O hex2bin.zip
fi
if [ ! -d hex2bin-master ]; then
    unzip hex2bin.zip
fi
cd hex2bin-master && make && cd ..
cp hex2bin-master/hex2bin bin/hex2bin
rm -rf hex2bin-master
rm -rf hex2bin.zip