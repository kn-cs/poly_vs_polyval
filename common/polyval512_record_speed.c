#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include "polyval512.h"
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

int main() {

	FILE *fpin,*fpout;
    	char *line,*ptr;
    	char filename[60];
    	size_t len;
    	ssize_t n;
    	float cycles;
    	int i,j,c,g,msglen;
    	ALIGN uchar8 str[3],k[KEY_SIZE];
    	ALIGN uchar8 m[MAX_MSG_SIZE]={0};
    	ALIGN uchar8 h[BLOCK_SIZE]={0};
    	ALIGN uint64 kp[MAX_KP_SIZE];
    	uint64 l,r,*q,nbytes;
    	
    	//#define SAGE
    	#ifdef SAGE
    	c = system("cd ../sage; sage polyval512_benchmark_msg_lengths.sage; cd ..");
    	remove("../sage/polyval512_benchmark_msg_lengths.sage.py");
    	#endif
    	
    	generate_key(KEY_LENGTH,"../test_data/polyval512_benchmark_keyfile.txt");
	format_key(k,KEY_LENGTH,"../test_data/polyval512_benchmark_keyfile.txt");
	 	
   	fpin = fopen("../test_data/polyval512_benchmark_msg_lengths.txt","r");
    	if (fpin == NULL) {
    	
    		printf("\nError opening input file of message lengths!\n\n");
        	exit(1);
        }

        strcpy(filename,"../benchmarks/polyval512_benchmarks_g");

        fpout = fopen("g","r");
        n = getline(&ptr,&len,fpout);
        ptr[n-1] = '\0';
        strcat(filename,ptr);
        fclose(fpout);
        	
	fpout = fopen(filename,"w");
    	if (fpout == NULL) {
    	
    		printf("\nError opening output file!\n\n");
        	exit(1);
        }

    	printf("\nBenchmarking..."); fflush(stdout);

	line = calloc(10,(sizeof(char)));
    	while ((n = getline(&line, &len, fpin)) != -1) {
    	
        	sscanf(line,"%d",&msglen);
        	generate_msg(msglen,"../test_data/polyval512_benchmark_msgfile.txt");
        	format_msg(m,msglen,"../test_data/polyval512_benchmark_msgfile.txt");
		
        	l = msglen / BLOCK_LENGTH; r = msglen % BLOCK_LENGTH;
     		if (r>0) l = l + 1;
		polyval512_keypowers(kp,(uint64 *)k,l);
        	
        	nbytes = msglen%8 == 0 ? msglen/8 : msglen/8+1;
        	 	   
    		for (long long i = 0;i <= TIMINGS;++i) {
      			t[i] = cpucycles();
      			polyval512(h,m,kp,l);
   		}
        	cycles = ((get_median())/(double)(nbytes));
        	fprintf(fpout,"%7llu  %7.4lf\n", l,cycles);
    	}
    	fclose(fpin); fclose(fpout);
    	free(line);
    	remove("../test_data/polyval512_benchmark_keyfile.txt");
    	remove("../test_data/polyval512_benchmark_msgfile.txt");
    	
    	printf("done!\n\n");

	return 0;
}
