#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include "poly256.h"
#include "poly_input.h"

int main() {

	FILE *fpin,*fpout;
    	char *line,*ptr,*msg;
    	size_t len;
    	ssize_t n;
    	int i,j,c,l,msglen;
    	uchar8 str[3],k[KEY_SIZE];
    	ALIGN uchar8 m[MAX_MSG_SIZE]={0};
    	ALIGN uchar8 h[BLOCK_SIZE]={0};
    	ALIGN uint64 kp[MAX_KP_SIZE]={0};
    	uint64 *q;
    	
    	//#define SAGE
    	#ifdef SAGE
    	c = system("cd ../sage; sage poly256_verify.sage; cd ..");
    	remove("../sage/poly256_verify.sage.py");
    	#endif
    	
      	format_key(k,KEY_LENGTH,"../test_data/poly256_verify_keyfile.txt");
    	   	
    	// tests for poly256
   	fpin = fopen("../test_data/poly256_verify_test_cases.txt","r");
    	if (fpin == NULL) {
    	
    		printf("\nError opening input file of messages!\n\n");
        	exit(1);
        }
        	
	fpout = fopen("../test_data/poly256_verify_c_outputs.txt","w");
    	if (fpout == NULL) {
    	
    		printf("\nError opening output file!\n\n");
        	exit(1);
        }
        
	line = calloc(16500,(sizeof(char)));
	msg  = calloc(16500,(sizeof(char)));
    	while ((n = getline(&line, &len, fpin)) != -1) {
    	
        	sscanf(line,"%s %d",msg,&msglen);
        	l = ((int)n-1)/64;
        	c = 0;
        	ptr = msg;
        	for (i=1;i<=l;++i) {
        	   		
        		for (j=63;j>=1;j=j-2) {
        		
        			str[0] = ptr[j-1];
        			str[1] = ptr[j];
        			m[c++] = strtol((const char *)str,NULL,16);
        		}
        		ptr = ptr + 64;
        	}

        	poly256_keypowers(kp,(uint64 *)k,l);
        	poly256(h,m,kp,l);
      		q = (uint64 *)h; fprintf(fpout,"%016llx%016llx%016llx%016llx\n",q[3],q[2],q[1],q[0]);
    	}
    	fclose(fpin); fclose(fpout);
    	free(line); free(msg);
    	
    	c = system("diff ../test_data/poly256_verify_c_outputs.txt ../test_data/poly256_verify_s_outputs.txt");
    	if (c == 0) printf("\nVerification tests for poly256 succeeded for all inputs!\n");
    	else printf("\nVerification tests for poly256 failed for some or all inputs!\n");
    	remove("../test_data/poly256_verify_c_outputs.txt");

	return 0;
}
