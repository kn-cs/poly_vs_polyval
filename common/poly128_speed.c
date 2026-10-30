#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include "poly128.h"
#include "poly_input.h"

#include "cpucycles.h"
#define TIMINGS 123
static long long t[TIMINGS+1];

long long get_median() {

	long long median = 0;

	for (long long i = 0;i < TIMINGS;++i)
    		t[i] = t[i+1]-t[i];
  	for (long long j = 0;j < TIMINGS;++j) {
    		long long belowj = 0;
    		long long abovej = 0;
    		for (long long i = 0;i < TIMINGS;++i) if (t[i] < t[j]) ++belowj;
    		for (long long i = 0;i < TIMINGS;++i) if (t[i] > t[j]) ++abovej;
    		if (belowj*2 < TIMINGS && abovej*2 < TIMINGS) {
      			median = t[j];
      			break;
    		}
  	}
  	return median;
}

int main(int argc, char **argv) {

	FILE *fp;
	uint64 msglen,l,n,r;
        uint64 *q;
	char *ptr;
    	size_t len;
               
	int c,g,v;

    	ALIGN uchar8 h[BLOCK_SIZE]={0};
    	ALIGN uchar8 k[KEY_SIZE];
    	ALIGN uchar8 m[MAX_MSG_SIZE]={0};
    	ALIGN uint64 kp[MAX_KP_SIZE];
	
	if (argc != 2) {
		printf("\nMissing message length as input. Aborting!\n\n" );
		exit(1);
	}
	msglen = atoi(argv[1]);
	if (msglen < 0 || msglen > MAX_MSG_LENGTH) {
		printf("\nInvalid message length. Aborting!\n\n" );
		exit(1);
	}
	
	generate_key(KEY_LENGTH,"../test_data/poly128_speed_keyfile.txt");
	format_key(k,KEY_LENGTH,"../test_data/poly128_speed_keyfile.txt");
	
	generate_msg(msglen,"../test_data/poly128_speed_msgfile.txt");
	
	if (msglen > 0) {
		format_msg(m,msglen,"../test_data/poly128_speed_msgfile.txt");
        }
        
	l = msglen / BLOCK_LENGTH; r = msglen % BLOCK_LENGTH;
	if (r > 0) l = l + 1;
	      
      	poly128_keypowers(kp,(uint64 *)k,l);
        
        //#define SAGE
        #ifdef SAGE
        poly128(h,m,kp,l);
	fp = fopen("../test_data/poly128_speed_c_output.txt","w");
    	if (fp == NULL) {
    	
    		printf("\nError opening output file!\n\n");
        	exit(1);
        }
        q = (uint64 *)h; fprintf(fp,"%016llx%016llx",q[1],q[0]);
        fclose(fp);
        
        c = system("cd ../sage; sage poly128_speed.sage; cd ..");
    	c = system("diff ../test_data/poly128_speed_c_output.txt ../test_data/poly128_speed_s_output.txt");
    	if (c == 0) printf("\nVerification test for poly128 succeeded for the given input!\n");
    	else printf("\nVerification test for poly128 failed for the given input!\n");
    	remove("../test_data/poly128_speed_s_output.txt");
    	remove("../sage/poly128_speed.sage.py");
    	#endif
        
     	printf("\nComputing CPU-cycles...\n\n");
	n = msglen%8 == 0 ? msglen/8 : msglen/8+1;
	if (msglen == 0) n = 1;
    	
    	for (long long i = 0;i <= TIMINGS;++i) {
      		t[i] = cpucycles();
      		poly128(h,m,kp,l);
   	}
	printf("CPU-cycles per byte for computing poly128 on a message of length %llu bits: %6.4lf\n\n", msglen,((get_median())/(double)(n)));

    	remove("../test_data/poly128_speed_c_output.txt");
    	remove("../test_data/poly128_speed_keyfile.txt");
    	remove("../test_data/poly128_speed_msgfile.txt");
	
	return 0;
}
