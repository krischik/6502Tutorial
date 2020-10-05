
Test.car: Test.o
	ld65				\
	    -C atari.cfg		\
	    -o Test.exe			\
	    Test.o

Test.o: Test.M65
	ca65			\
	    --cpu 6502		\
	    --target atari	\
	    Test.M65

run: Test.car
	atari800						\
	    -autosave-config					\
	    -cart-type 1					\
	    -video-accel					\
	    -xe 						\
   	    -nobasic						\
    	    -pal						\
    	    -win-height	    1120				\
    	    -win-width	    1680				\
	    -config    	"Test.cfg"				\
	    -xlxe_rom  	"/opt/local/share/atari800/ATARIXL.ROM"

clean:
	rm 

# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=0 noexpandtab :
# vim: set textwidth=0 filetype=make foldmethod=marker nospell :
