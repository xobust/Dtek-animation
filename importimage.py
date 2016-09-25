from PIL import Image
import sys

#Created by Johan Ribom

im = Image.open(sys.argv[1]) #Can be many different formats.
pix = im.load()
size = im.size
lista = []
for i in range(0, size[0]*4):
	value = 0;
	for num in range(0, 8):
		if pix[i % 32, (i / 32)*8 + num] < 128:
			value += 2**num
	lista.append(value)

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

for i in range(0, (len(lista))/8):
	f.write("\t")
	for num in lista[i*8:(i+1)*8]:
		f.write(str(num) + ", ")
	f.write("\n")

f.write("};")
f.close()
