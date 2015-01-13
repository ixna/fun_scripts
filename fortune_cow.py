#!/usr/bin/env python

__author__ = 'Isna Rahmatul Khoir <isna@sebangsa.com>'

import os 
import sys

if len(sys.argv)<2:
    fortune = os.popen("fortune").readlines()
else:
    fortune = [i for i in sys.argv[1].split("\n")]

maxln = max(len(i.replace("\n", "")) for i in fortune)
pertama = fortune[0].strip().replace("\t"," ")

if len(fortune)==1:
    print "<"+pertama+">"
    
else:
    kurang = maxln-len(pertama)
    print "/"+pertama+" "*kurang+"\\"

    for i in  fortune[1:-1]:
        kalimat = i.strip().replace("\t", " ")
        kurang = maxln-len(kalimat)
        print "|"+kalimat+" "*(kurang)+"|"

    terakhir = fortune[-1].strip().replace("\t", " ")
    if terakhir.startswith("--"):
        print "|"+" "*maxln+"|"
    kurang = maxln-len(terakhir)
    print "\\"+terakhir+" "*kurang+"/"
    

print " "+"-"*maxln
print "                \\   _(__)_        V"
print "                 \\ '-e e -'__,--.__)"
print "                    (o_o)        ) "
print "                       \. /___.  |"
print "                       //_(/_(/_("