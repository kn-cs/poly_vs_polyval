# Author: Kaushik Nath

def getKeyRandom(k,file):

	key = []
	f = open(file,"w")
	for i in range(k):
		bit = F2.random_element()
		key.append(bit)
		f.write(str(bit))
	f.close()
	return key

def getRandomString(n):
     
	s = ""
	for i in range(1,n+1):
         
		b = random.randint(0,1)
		s += str(b)
	return s
	
def getKeyFromFile(file):

	key = []
	f = open(file,"r")
	s = f.readline()
	for i in range(k):
		key.append(s[i])
	f.close()
	return key
	
def getMsgFromFile(file):

	f = open(file,"r")
	msg = []
	s = f.readline()
	l = len(s)
	for i in range(l):
		msg.append(s[i])
	f.close()
	return msg,l
