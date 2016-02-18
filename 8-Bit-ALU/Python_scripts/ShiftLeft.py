file = open('ShiftLeft.txt', 'w')
for i in range(0, 256):
	for j in range(0, 8):
		the_lshift = (i << j) % 256
		file.write("{0:08b}".format(i) + " " + "{0:08b}".format(j) + " " + "{0:08b}".format(the_lshift) + "\n")
file.close()