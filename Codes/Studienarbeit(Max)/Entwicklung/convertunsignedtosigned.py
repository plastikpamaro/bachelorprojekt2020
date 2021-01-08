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
        number = int(data[0])
        n = number & 0xffffff
        number =  n | (-(n & 0x400000))
        outputfile.write(str(number)+'\n')
        
    rowcounter = rowcounter + 1

print(rowcounter)

print(5)