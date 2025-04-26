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
if [ ! -f asxxxx.zip ]; then
    wget https://github.com/JorgeJuarezM/asxxxx/archive/refs/heads/macos.zip -O asxxxx.zip
else
    echo "asxxxx.zip already exists -> skipping download"
fi

if [ ! -d asxxxx-macos ]; then
    unzip asxxxx.zip
else
    echo "asxxxx-macos already exists -> skipping unzip"
fi

cd asxxxx-macos && make asz80 && make aslink && cd ..
mv asxxxx-macos/dist/asz80 bin
mv asxxxx-macos/dist/aslink bin


rm -rf asxxxx.zip
rm -rf asxxxx-macos

EXISTS=$(grep "^export ZXENGINE_HOME=" ~/.zshrc)
if [ ! -n "$EXISTS" ]; then
    echo "" >> ~/.zshrc
    echo "# ZXEngine" >> ~/.zshrc
    echo "export ZXENGINE_HOME=$(pwd)" >> ~/.zshrc
    echo "export PATH=\$PATH:\$ZXENGINE_HOME/bin" >> ~/.zshrc
fi
