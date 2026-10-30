# Author: Kaushik Nath

def genBenchmarkMsgLengths():
   	
	f = open("../test_data/polyval512_benchmark_msg_lengths.txt", "w")
	start = 512
	stop = 51200+512
	step = 512
	for msgLen in range(start,stop,step):
		for i in range(1,2):
			f.write("%d\n"%msgLen)
			
	start = 64000
	stop = 128000+512
	step = 12800
	for msgLen in range(start,stop,step):
		for i in range(1,2):
			f.write("%d\n"%msgLen)
			
	lst = [131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216, 33554432]
	for msgLen in lst:
		for i in range(1,2):
			f.write("%d\n"%msgLen)
	f.close()
	
genBenchmarkMsgLengths()
