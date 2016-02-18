file = open('ALU.txt', 'w')
for i in range(0, 256):
    for j in range(0, 256):
        the_sum = (i + j) % 256
        file.write("{0:08b}".format(i) + " " + "{0:08b}".format(j) + " 00 " + "{0:08b}".format(the_sum) + "\n")

for i in range(0, 256):
    for j in range(0, 256):
        the_dif = (i - j) % 256
        file.write("{0:08b}".format(i) + " " + "{0:08b}".format(j) + " 01 " + "{0:08b}".format(the_dif) + "\n")

for i in range(0, 256):
    for j in range(0, 8):
        the_rshift = (i >> j) % 256
        file.write("{0:08b}".format(i) + " " + "{0:08b}".format(j) + " 10 " + "{0:08b}".format(the_rshift) + "\n")

for i in range(0, 256):
    for j in range(0, 8):
        the_lshift = (i << j) % 256
        file.write("{0:08b}".format(i) + " " + "{0:08b}".format(j) + " 11 " + "{0:08b}".format(the_lshift) + "\n")

file.close()