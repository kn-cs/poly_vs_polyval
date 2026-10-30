#include "polyval.h"

void polyval(uchar8 *h,uchar8 *m,const uint64 *k,const uint64 l) {

	uint64 *p;
	
	if (l == 0) {
	
		p = (uint64 *)h;
		*p = 0; *(p+1) = 0;
		return;
	}
		
	/*
	 *  h: output
	 *  m: input message
	 *  k: key powers array
	 *  l: number of blocks
	 */
	polyval_asm((uint64 *)h,(uint64 *)m,k,l);
}
