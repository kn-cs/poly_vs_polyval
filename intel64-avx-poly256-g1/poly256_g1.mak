INCDRS = -I../include/

SRCFLS = ../common/poly256_const.S                         \
        ../common/poly256_input.c                          \
        ../common/poly256.c                                \
        ./poly256_g1.S                                     \
        ./poly28_keypowers_g1.S
         
OBJFLS = ../common/poly256_const.o                         \
        ../common/poly256_input.o                          \
        ../common/poly256.o                                \
        ./poly256_g1.o                                     \
        ./poly256_keypowers_g1.o

TESTSRC = ../common/poly256_verify.c
TESTOBJ = ../common/poly256_verify.o

SPEEDSRC = ../common/poly256_speed.c
SPEEDOBJ = ../common/poly256_speed.o

RECORDSRC = ../common/poly256_record_speed.c
RECORDOBJ = ../common/poly256_record_speed.o
         
EXE1    = poly256_verify
EXE2    = poly256_speed
EXE3    = poly256_record_speed

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

