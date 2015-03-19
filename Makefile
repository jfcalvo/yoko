.PHONY : all clean

all:
	make -C mruby
	cp mruby/bin/mruby bin/yoko
	cp mruby/bin/mirb bin/iyoko

clean:
	make clean -C mruby
	mkdir -p bin
	rm -f bin/yoko
	rm -f bin/iyoko
