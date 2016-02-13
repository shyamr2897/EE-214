file = open('EightBitSubtractor.txt', 'w')
for i in range(0, 256):
	for j in range(0, 256):
		the_dif = (i - j) % 256
		file.write("{0:08b}".format(i) + " " + "{0:08b}".format(j) + " " + "{0:08b}".format(the_dif) + "\n")
file.close()