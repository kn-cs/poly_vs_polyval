# Author: Palash Sarkar

import random

ZZ = IntegerRing()
F2 = GF(2); # binary field
R.<x> = PolynomialRing(F2) # polynomial ring over F2
n = 256; # n is the block size
k = 256 # k is the key size
p = x^(256) +  x^10 + x^5 + x^2 + 1 # the irreducible polyomial used to represent the field
Fn.<X> = GF(2^(n), modulus=p) # the extension field

def Lst2FldElem(Lst): # converts a 0-1 list of size at most n to the corresponding field element

        if (not Lst):
                return Fn._cache.fetch_int(0)
        Str = "".join(str(i) for i in Lst)
        toInt = int(Str, 2)
        fld_elem = Fn._cache.fetch_int(toInt)
        return fld_elem

def FldElem2Lst(fld_elem): # converts a field element to the corresponding 0-1 list of size n

    	deg = fld_elem.polynomial().degree()
    	lst = [0]*n
    	polyLst = fld_elem.polynomial().coefficients(sparse=false)
    	for i in range(deg+1):
        	lst[i] = polyLst[i]
    	return lst

def Lst2Str(Lst):

    	return "".join(map(str,Lst))

def FldElem2Int(fld_elem):

    	tmp = FldElem2Lst(fld_elem)
    	tmp.reverse()
    	return int(Lst2Str(tmp),2)

def Int2FldElem(Int):

    	Lst = ZZ(Int).digits(2)
    	Lst.reverse()
    	return Lst2FldElem(Lst)

def getKeyFldElt(key):
 
    	return Lst2FldElem(key);
    	
def formatMsg(msg,msgLen,msgEltsLst,n):

    	if (msgLen == 0):
        	m = 0
        	msgEltsLst = []
        	return m
    	r = ZZ(mod(msgLen,n))
    	if (r == 0):
        	m = msgLen/n
        	lastlen = n
    	else:
        	m = 1 + floor(msgLen/n)
        	lastlen = r

    	for i in range(m-1):
        	c = ZZ(0)
        	for j in range(n):
            		c = 2*c + ZZ(msg[i*n+j])
        	msgEltsLst.append(Fn._cache.fetch_int(c))
    	c = ZZ(0)
    	for j in range(lastlen):
        	c = 2*c + ZZ(msg[(m-1)*n+j])
    	msgEltsLst.append(Fn._cache.fetch_int(c))
    	return m
	
def Horner(keyFldElt, msgEltsLst, msgLen):
    
    	m = len(msgEltsLst)
    	if (m == 0):
        	return Fn(0)
    	val = keyFldElt*msgEltsLst[0]
    	for i in range(1,m):
        	val = keyFldElt * (val + msgEltsLst[i])
    	return val
