INCDRS = -I../include/

SRCFLS = ../common/polyval512_const.S                      \
        ../common/polyval512_input.c                       \
        ../common/polyval512.c                             \
        ./polyval512_g1.S                                  \
        ./poly28_keypowers_g1.S
         
OBJFLS = ../common/polyval512_const.o                      \
        ../common/polyval512_input.o                       \
        ../common/polyval512.o                             \
        ./polyval512_g1.o                                  \
        ./polyval512_keypowers_g1.o

TESTSRC = ../common/polyval512_verify.c
TESTOBJ = ../common/polyval512_verify.o

SPEEDSRC = ../common/polyval512_speed.c
SPEEDOBJ = ../common/polyval512_speed.o

RECORDSRC = ../common/polyval512_record_speed.c
RECORDOBJ = ../common/polyval512_record_speed.o
         
EXE1    = polyval512_verify
EXE2    = polyval512_speed
EXE3    = polyval512_record_speed

CFLAGS = -march=native -mtune=native -mavx -mno-avx2 -mno-avx512f -m64 -O3 -funroll-loops -fomit-frame-pointer

CC     = gcc
LL     = gcc

all:	$(EXE1) $(EXE2) $(EXE3)

$(EXE1): $(TESTOBJ) $(OBJFLS)
	$(LL) -o $@ $(OBJFLS) $(TESTOBJ) -lm
	
$(EXE2): $(SPEEDOBJ) $(OBJFLS)
	$(LL) -o $@ $(OBJFLS) $(SPEEDOBJ) -lm -lcpucycles
	
$(EXE3): $(RECORDOBJ) $(OBJFLS)
	$(LL) -o $@ $(OBJFLS) $(RECORDOBJ) -lm -lcpucycles

.c.o:
	$(CC) $(INCDRS) $(CFLAGS) -o $@ -c $<

clean:
	-rm $(EXE1) $(EXE2) $(EXE3)
	-rm $(TESTOBJ) $(SPEEDOBJ) $(RECORDOBJ)
	-rm $(OBJFLS)

