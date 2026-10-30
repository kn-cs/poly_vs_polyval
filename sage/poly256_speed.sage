# Author: Kaushik Nath

load("poly256.sage")
load("poly256_support.sage")

def testSpeedCase():
	
	f1 = open("../test_data/poly256_speed_s_output.txt", "w")
	f2 = open("../test_data/poly256_hash_speed_s_output.txt", "w")
	key = getKeyFromFile("../test_data/poly256_speed_keyfile.txt")
	keyFldElt = getKeyFldElt(key)
	msg, msgLen = getMsgFromFile("../test_data/poly256_speed_msgfile.txt")
	msgEltsLst = []
	m = formatMsg(msg,msgLen,msgEltsLst,n)
	digest = Horner(keyFldElt,msgEltsLst,msgLen)
	f1.write("%064x"%FldElem2Int(digest))
	digest = keyFldElt*(digest + Int2FldElem(msgLen))
	f2.write("%064x"%FldElem2Int(digest))
	
testSpeedCase()
