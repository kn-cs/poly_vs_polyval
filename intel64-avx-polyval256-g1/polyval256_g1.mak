INCDRS = -I../include/

SRCFLS = ../common/polyval256_const.S                      \
        ../common/polyval256_input.c                       \
        ../common/polyval256.c                             \
        ./polyval256_g1.S                                  \
        ./poly28_keypowers_g1.S
         
OBJFLS = ../common/polyval256_const.o                      \
        ../common/polyval256_input.o                       \
        ../common/polyval256.o                             \
        ./polyval256_g1.o                                  \
        ./polyval256_keypowers_g1.o

TESTSRC = ../common/polyval256_verify.c
TESTOBJ = ../common/polyval256_verify.o

SPEEDSRC = ../common/polyval256_speed.c
SPEEDOBJ = ../common/polyval256_speed.o

RECORDSRC = ../common/polyval256_record_speed.c
RECORDOBJ = ../common/polyval256_record_speed.o
         
EXE1    = polyval256_verify
EXE2    = polyval256_speed
EXE3    = polyval256_record_speed

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

