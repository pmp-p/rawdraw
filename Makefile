all : rawdraw simple

#for X11 consider:             xorg-dev
#for X11, you will need:       libx-dev
#for full screen you'll need:  libxinerama-dev libxext-dev
#for OGL You'll need:          mesa-common-dev libglu1-mesa-dev

#-DCNFGRASTERIZER
#  and
#-CNFGOGL
#  are incompatible.


MINGW32:=/usr/bin/i686-w64-mingw32-

rawdraw.exe : rawdraw.c
	$(MINGW32)gcc -g -m32 -o $@ $^  -lgdi32

rawdrawogl.exe : rawdraw.c
	$(MINGW32)gcc -g -m32 -o $@ $^  -lgdi32 -DCNFGOGL -lopengl32

rawdraw_egl : rawdraw.c
	gcc -o $@ $^ -lMali -lpthread -lm -O3

simple : simple.c
	gcc -o $@ $^ -lX11 -lpthread -lXinerama -lXext -lGL -g -lm -ldl

rawdraw : rawdraw.c
	gcc -o $@ $^ -lX11 -lpthread -lXinerama -lXext -lGL -g -lm -ldl

rawdraw_ogl : rawdraw.c
	gcc -o $@ $^ -lX11 -lpthread -lXinerama -lXext -lGL -g -DCNFGOGL -lm -ldl

osdtest : osdtest.c CNFG.c
	gcc -o $@ $^ -lX11 -lpthread -lXinerama -lXext -DHAS_XINERAMA -DHAS_XSHAPE -lm -ldl

ogltest : ogltest.c CNFG.c
	gcc -o $@ $^  -lX11 -lXinerama -lGL   -DCNFGOGL -lm

ogltest.exe : ogltest.c CNFG.c
	$(MINGW32)gcc -o $@ $^ -lgdi32 -lkernel32 -lopengl32 -DCNFGOGL -lm

clean : 
	rm -rf *.o *~ rawdraw.exe rawdrawogl.exe rawdraw rawdraw_ogl rawdraw_mac rawdraw_mac_soft rawdraw_mac_cg rawdraw_mac_ogl ogltest ogltest.exe rawdraw_egl

