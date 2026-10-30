INCDRS = -I../include/

SRCFLS = ../common/polyval_const.S                         \
        ../common/polyval_input.c                          \
        ../common/polyval.c                                \
        ./polyval_g1.S                                     \
        ./polyval_keypowers_g1.S                           \
         
OBJFLS = ../common/polyval_const.o                         \
        ../common/polyval_input.o                          \
        ../common/polyval.o                                \
        ./polyval_g1.o                                     \
        ./polyval_keypowers_g1.o                           \

TESTSRC = ../common/polyval_verify.c
TESTOBJ = ../common/polyval_verify.o

SPEEDSRC = ../common/polyval_speed.c
SPEEDOBJ = ../common/polyval_speed.o

RECORDSRC = ../common/polyval_record_speed.c
RECORDOBJ = ../common/polyval_record_speed.o
         
EXE1    = polyval_verify
EXE2    = polyval_speed
EXE3    = polyval_record_speed

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

