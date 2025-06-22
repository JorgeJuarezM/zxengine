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
export ZXE_HOME=~/.zxengine
function setEnv() {
    ENV_FILE=$1
    if [ ! -f "$ENV_FILE" ]; then
        return
    fi
    EXISTS=$(grep "^export ZXE_HOME=" $ENV_FILE)
    if [ ! -n "$EXISTS" ]; then
        echo "Setting up environment variables in $ENV_FILE"
        echo "" >> $ENV_FILE
        echo "# ZXEngine" >> $ENV_FILE
        echo "export ZXE_HOME=${ZXE_HOME}" >> $ENV_FILE
        echo "export PATH=\$PATH:\$ZXE_HOME/bin" >> $ENV_FILE
    fi
}

# Install zxengine
make install ZXE_HOME=$ZXE_HOME
make ZXE_HOME=$ZXE_HOME

# Export ZXEngine Home in user profiles.
setEnv ~/.zshrc
setEnv ~/.bash_profile
setEnv ~/.bashrc
