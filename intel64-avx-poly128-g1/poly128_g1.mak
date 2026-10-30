INCDRS = -I../include/

SRCFLS = ../common/poly128_const.S                         \
        ../common/poly128_input.c                          \
        ../common/poly128.c                                \
        ./poly128_g1.S                                     \
        ./poly28_keypowers_g1.S
         
OBJFLS = ../common/poly128_const.o                         \
        ../common/poly128_input.o                          \
        ../common/poly128.o                                \
        ./poly128_g1.o                                     \
        ./poly128_keypowers_g1.o

TESTSRC = ../common/poly128_verify.c
TESTOBJ = ../common/poly128_verify.o

SPEEDSRC = ../common/poly128_speed.c
SPEEDOBJ = ../common/poly128_speed.o

RECORDSRC = ../common/poly128_record_speed.c
RECORDOBJ = ../common/poly128_record_speed.o
         
EXE1    = poly128_verify
EXE2    = poly128_speed
EXE3    = poly128_record_speed

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

