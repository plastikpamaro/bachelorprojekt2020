import csv

filename = input('Enter file name:')
number = 0

newfilename = filename.split('.')
newfilename = newfilename[0] + '_signed.csv'
outputfile = open(newfilename, 'w')

inputfile = open(filename) 
rowcounter = 0
for rows in inputfile:
    if rowcounter == 0:
        pass
    elif rowcounter == 1:
        pass
    else:
        data = rows.split(',')
        number0 = int(data[0])
        number1 = int(data[1])
        number2 = int(data[2])
        number3 = int(data[3])
        number4 = int(data[4])
        number5 = int(data[5])
        n0 = number0 & 0xffffff
        n1 = number1 & 0xffffff
        n2 = number2 & 0xffffff
        n3 = number3 & 0xffffff
        n4 = number4 & 0xffffff
        n5 = number5 & 0xffffff
        number0 =  n0 | (-(n0 & 0x400000))
        number1 =  n1 | (-(n1 & 0x400000))
        number2 =  n2 | (-(n2 & 0x400000))
        number3 =  n3 | (-(n3 & 0x400000))
        number4 =  n4 | (-(n4 & 0x400000))
        number5 =  n5 | (-(n5 & 0x400000))
        outputfile.write(str(number0)+';')
        outputfile.write(str(number1)+';')
        outputfile.write(str(number2)+';')
        outputfile.write(str(number3)+';')
        outputfile.write(str(number4)+';')
        outputfile.write(str(number5)+'\n')
    rowcounter = rowcounter + 1

print(rowcounter)

print(5)