from PIL import Image
import sys
import glob 
import os

"""
    Skapad av Johan Ribom, modiierad av Alexander Bladh
"""

newfile = []
f = open('mipslabdata.c', 'r')
for line in f:
	newfile.append(line)
        if 'const uint8_t const icon[' in line:
		break
f.close()
f = open('mipslabdata.c', 'w')
for line in newfile:
        f.write(line)

last = False
n_frames = 0;
for filename in sorted(glob.glob(os.path.join(os.getcwd(), '*.png'))):
    n_frames += 1
    if last:
       f.write("},{") 
    else:
        f.write("{")
        last = True

    print(filename)
    im = Image.open(filename) #Can be many different formats.
    pix = im.load()
    size = im.size
    lista = []
    for i in range(0, size[0]*4):
            value = 0;
            for num in range(0, 8):
                    if pix[i % 32, (i / 32)*8 + num] < 128:
                            value += 2**num
            lista.append(value)


    for i in range(0, (len(lista))/8):
            f.write("\t")
            for num in lista[i*8:(i+1)*8]:
                    f.write(str(num) + ", ")
            f.write("\n")

f.write("}};")
f.close()

print str(n_frames) + " frames written"
print "Please modify the frames define in mipslab.h"
