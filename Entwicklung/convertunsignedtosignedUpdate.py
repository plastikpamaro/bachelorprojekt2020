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
        outputstring = ''
        for i in range(0,5):
            element = data[i]
            element = element.replace(' ','')
            element = element.replace('\n','')
            number = int(element)
            n = number & 0xffffff
            number =  n | (-(n & 0x400000))
            if i == 0:
                outputstring = str(number)
            else:
                outputstring = outputstring + ',' + str(number)
        outputstring = outputstring + ',' + data[6]

        outputfile.write(outputstring)
        
    rowcounter = rowcounter + 1

print(rowcounter)

print(5)