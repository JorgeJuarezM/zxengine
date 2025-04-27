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
if [[ "$OSTYPE" == "darwin"* ]]; then
    ZIP_FILE="macos"
else
    ZIP_FILE="master"
fi

echo "Downloading asxxxx-macos"
if [ ! -f asxxxx.zip ]; then
    wget https://github.com/JorgeJuarezM/asxxxx/archive/refs/heads/$ZIP_FILE.zip \
        -O asxxxx.zip > /dev/null 2>&1
fi

echo "Unzipping asxxxx-macos"
if [ ! -d asxxxx-macos ]; then
    unzip asxxxx.zip > /dev/null 2>&1
fi

echo "Building asz80 and aslink"
cd asxxxx-$ZIP_FILE \
    && make asz80 > /dev/null 2>&1 \
    && make aslink > /dev/null 2>&1 \
    && cd .. > /dev/null

mv asxxxx-$ZIP_FILE/dist/asz80 bin
mv asxxxx-$ZIP_FILE/dist/aslink bin

echo "Cleaning up"
rm -rf asxxxx.zip
rm -rf asxxxx-$ZIP_FILE

function setEnv() {
    ENV_FILE=$1
    if [ ! -f "$ENV_FILE" ]; then
        return
    fi

    EXISTS=$(grep "^export ZXENGINE_HOME=" $ENV_FILE)
    if [ ! -n "$EXISTS" ]; then
        echo "Setting up environment variables in $ENV_FILE"
        echo "" >> $ENV_FILE
        echo "# ZXEngine" >> $ENV_FILE
        echo "export ZXENGINE_HOME=$(pwd)" >> $ENV_FILE
        echo "export PATH=\$PATH:\$ZXENGINE_HOME/bin" >> $ENV_FILE
    fi
}

setEnv ~/.zshrc
setEnv ~/.bash_profile
setEnv ~/.bashrc

echo "Done"