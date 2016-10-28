.PHONY : all clean pull_mruby pull_mruby_sdl2 pull_mruby_io

all:
	make -C mruby
	mkdir -p bin
	cp mruby/bin/mruby bin/yoko
	cp mruby/bin/mirb bin/iyoko

clean:
	make clean -C mruby
	rm -f bin/yoko
	rm -f bin/iyoko

pull_mruby:
	git subtree pull --prefix mruby git@github.com:jfcalvo/yoko-mruby.git yoko-1.2.0 --squash

pull_mruby_sdl2:
	git subtree pull --prefix mruby-sdl2 git@github.com:jfcalvo/yoko-mruby-sdl2.git yoko --squash

pull_mruby_io:
	git subtree pull --prefix mruby-io git@github.com:iij/mruby-io.git master --squash
