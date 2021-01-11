source = open('data_240520_183213.audio','rb')
dest = open('output.csv','w')

counter = 0

while True:
    datapackage = source.read(36)
    if not datapackage:
         break
    data = [0,0,0,0,0,0,0,0,0]
    for i in range(0,9):
        data[i] = str(int((datapackage[(i*4)+3] << 24) | (datapackage[(i*4)+2] << 16) | (datapackage[(i*4)+1] << 8) | datapackage[(i*4)+0]))
    dest.write(data[0] + ',' + data[1] + ',' + data[2] + ',' + data[3] + ',' + data[4] + ',' + data[5] + ',' + data[6] + ',' + data[7] + ',' + data[8] +'\n')
    #counter = counter + 1
    #if not counter % 1000:
    #    print (counter/1000)

source.close()
dest.close()
