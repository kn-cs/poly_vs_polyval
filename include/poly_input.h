#ifndef __POLY_PROCESS_INPUT__
#define __POLY_PROCESS_INPUT__

#include "poly_basictypes.h"

void generate_key(int,const char *);
void generate_msg(int,const char *);
void format_key(uchar8 *,const int,const char *);
void format_msg(uchar8 *,const int,const char *);

#endif
