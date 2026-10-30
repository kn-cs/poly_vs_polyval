# Author: Kaushik Nath

def genBenchmarkMsgLengths():
   	
	f = open("../test_data/poly128_benchmark_msg_lengths.txt", "w")
	start = 128
	stop = 25600+128
	step = 128
	for msgLen in range(start,stop,step):
		for i in range(1,2):
			f.write("%d\n"%msgLen)
			
	start = 32000
	stop = 64000+128
	step = 6400
	for msgLen in range(start,stop,step):
		for i in range(1,2):
			f.write("%d\n"%msgLen)
			
	lst = [65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216, 33554432]
	for msgLen in lst:
		for i in range(1,2):
			f.write("%d\n"%msgLen)
	f.close()
	
genBenchmarkMsgLengths()
