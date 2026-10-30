INCDRS = -I../include/ -I/home/kaushik/include/

SRCFLS = ../common/poly512_const.S                         \
        ../common/poly512_input.c                          \
        ../common/poly512.c                                \
        ./poly512_g1.S                                     \
        ./poly28_keypowers_g1.S
         
OBJFLS = ../common/poly512_const.o                         \
        ../common/poly512_input.o                          \
        ../common/poly512.o                                \
        ./poly512_g1.o                                     \
        ./poly512_keypowers_g1.o

TESTSRC = ../common/poly512_verify.c
TESTOBJ = ../common/poly512_verify.o

SPEEDSRC = ../common/poly512_speed.c
SPEEDOBJ = ../common/poly512_speed.o

RECORDSRC = ../common/poly512_record_speed.c
RECORDOBJ = ../common/poly512_record_speed.o
         
EXE1    = poly512_verify
EXE2    = poly512_speed
EXE3    = poly512_record_speed

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

