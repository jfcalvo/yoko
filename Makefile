.PHONY : all clean

all:
	make -C mruby
	mkdir -p bin
	cp mruby/bin/mruby bin/yoko
	cp mruby/bin/mirb bin/iyoko

clean:
	make clean -C mruby
	rm -f bin/yoko
	rm -f bin/iyoko
