#ifndef __POLYVAL512__
#define __POLYVAL512__

#include "poly_basictypes.h"

#if defined(__AVX512F__) && (__AVX2__) && (__AVX__)
#define ALIGN __attribute__ ((aligned(64)))
#elif defined(__AVX2__) && (__AVX__)
#define ALIGN __attribute__ ((aligned(32)))
#elif defined(__AVX__)
#define ALIGN __attribute__ ((aligned(16)))
#endif

#define KEY_LENGTH 512
#define BLOCK_LENGTH 512
#define KEY_SIZE 64
#define BLOCK_SIZE 64
#define MAX_MSG_SIZE 4194304
#define MAX_MSG_LENGTH 33554432
#define MAX_KP_SIZE 8

void polyval512(uchar8 *,uchar8 *,const uint64 *,const uint64);

extern void polyval512_asm(uint64 *,const uint64 *,const uint64 *,const uint64);
extern void polyval512_keypowers(uint64 *,const uint64 *,const uint64);

#endif
