#ifndef __POLY128__
#define __POLY128__

#include "poly_basictypes.h"

#if defined(__AVX512F__) && (__AVX2__) && (__AVX__)
#define ALIGN __attribute__ ((aligned(64)))
#elif defined(__AVX2__) && (__AVX__)
#define ALIGN __attribute__ ((aligned(32)))
#elif defined(__AVX__)
#define ALIGN __attribute__ ((aligned(16)))
#endif

#define KEY_LENGTH 128
#define BLOCK_LENGTH 128
#define KEY_SIZE 16
#define BLOCK_SIZE 16
#define MAX_MSG_SIZE 4194304
#define MAX_MSG_LENGTH 33554432
#define MAX_KP_SIZE 64

void poly128(uchar8 *,uchar8 *,const uint64 *,const uint64);

extern void poly128_asm(uint64 *,const uint64 *,const uint64 *,const uint64);
extern void poly128_keypowers(uint64 *,const uint64 *,const uint64);

#endif
