# Author: Kaushik Nath

load("polyval512.sage")
load("polyval512_support.sage")
	
def genTestCases():

	key = getKeyRandom(k,"../test_data/polyval512_verify_keyfile.txt")
	keyFldElt = getKeyFldElt(key)
	keyFldElt = keyFldElt*Xpowminusn
    	
	f1 = open("../test_data/polyval512_verify_test_cases.txt","w")
	f2 = open("../test_data/polyval512_verify_s_outputs.txt","w")
	f3 = open("../test_data/polyval512_hash_verify_s_outputs.txt","w")
	start = 1
	stop = 2048
	step = 1
	for msgLen in range(start,stop,step):
		for i in range(1,2):
			msg = getRandomString(msgLen)
			msgEltsLst = []
			m = formatMsg(msg,msgLen,msgEltsLst,n)
			m = len(msgEltsLst)
			for j in range(0,m):
				f1.write("%0128x"%FldElem2Int(msgEltsLst[j]))
			f1.write(" %d\n"%msgLen)
			digest = Horner(keyFldElt,msgEltsLst,msgLen)
			f2.write("%0128x"%FldElem2Int(digest))
			f2.write("\n")
			digest = keyFldElt*(digest + Int2FldElem(msgLen))
			f3.write("%0128x"%FldElem2Int(digest))
			f3.write("\n")
			
	start = 2048
	stop = 65536+512
	step = 512
	for msgLen in range(start,stop,step):
		for i in range(1,2):
			msg = getRandomString(msgLen)
			msgEltsLst = []
			m = formatMsg(msg,msgLen,msgEltsLst,n)
			m = len(msgEltsLst)
			for j in range(0,m):
				f1.write("%0128x"%FldElem2Int(msgEltsLst[j]))
			f1.write(" %d\n"%msgLen)
			digest = Horner(keyFldElt,msgEltsLst,msgLen)
			f2.write("%0128x"%FldElem2Int(digest))
			f2.write("\n")
			digest = keyFldElt*(digest + Int2FldElem(msgLen))
			f3.write("%0128x"%FldElem2Int(digest))
			f3.write("\n")
	f1.close()
	f2.close()
	f3.close()

genTestCases()
