#!/bin/bash
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
