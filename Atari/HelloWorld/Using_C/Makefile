
Exe_File	= HELLO.COM
System_Files 	= "/opt/local/share/atari800"
User_Files 	= "$(HOME)/Library/Application\ Support/Atari800"

$(Exe_File): HelloWorld.c
	ld65			\
	    --target atari	\
	    --lib atari.lib	\
	    -o $(Exe_File)	\
	    HelloWorld.o

HelloWorld.o: HelloWorld.s
	ca65			\
	    --cpu 6502		\
	    --target atari	\
	    -o HelloWorld.o	\
	    HelloWorld.s

HelloWorld.s: HelloWorld.c
	cc65			\
	    --cpu 6502		\
	    --target atari	\
	    -o HelloWorld.s	\
	    HelloWorld.c

run: $(Exe_File)
	atari800						\
	    -autosave-config					\
	    -cart-type 1					\
	    -hreadwrite						\
	    -video-accel					\
	    -320xe 						\
   	    -nobasic						\
    	    -pal						\
    	    -win-height	    1120				\
    	    -win-width	    1680				\
	    -config    	"$(CURDIR)/HelloWorld.cfg"		\
	    -H1 	"$(CURDIR)"				\
	    -xlxe_rom  	"$(System_Files)/ATARIXL.ROM"		\
	    "$(User_Files)/Disks/CC65-Development.xfd"

clean:
	rm -v 			\
	    $(Exe_File)  	\
	    HelloWorld.o	\
	    HelloWorld.lst

# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=0 noexpandtab :
# vim: set textwidth=0 filetype=make foldmethod=marker nospell :
