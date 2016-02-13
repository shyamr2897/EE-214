file = open('EightBitAdder.txt', 'w')
for i in range(0, 256):
	for j in range(0, 256):
		the_sum = (i + j) % 256
		file.write("{0:08b}".format(i) + " " + "{0:08b}".format(j) + " " + "{0:08b}".format(the_sum) + "\n")
file.close()