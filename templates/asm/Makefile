build:
	asz80 -l -o main src/main.asm
	aslink -n -u -b _CODE=0x8000 -o -i main.ihx main.rel
	hex2bin main.ihx
	tapify --startaddr 32768 main.bin main.tmp.tap
	bas2tap --autostart 10 $(ZXENGINE_HOME)/templates/basic/loader.bas loader.tmp.tap
	cat loader.tmp.tap main.tmp.tap > game.tap
	rm *.tmp.tap
	rm *.bin
	rm *.ihx
	rm *.rel
	rm *.hlr
	rm *.lst
	rm *.rst
	/Applications/zesarux.app/Contents/MacOS/zesarux $(PWD)/game.tap