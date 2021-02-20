def dataconverter(raw_data):
    data = [0, 0, 0, 0, 0, 0, 0]
    data[0] = int.from_bytes(raw_data[0:4], byteorder='little')
    data[1] = convert(int.from_bytes(raw_data[4:8], byteorder='little'))
    data[2] = convert(int.from_bytes(raw_data[8:12], byteorder='little'))
    data[3] = convert(int.from_bytes(raw_data[12:16], byteorder='little'))
    data[4] = convert(int.from_bytes(raw_data[16:20], byteorder='little'))
    data[5] = convert(int.from_bytes(raw_data[20:24], byteorder='little'))
    data[6] = convert(int.from_bytes(raw_data[24:28], byteorder='little'))
    text = str(data[0]) + "," + str(data[1]) + "," + str(data[2]) + "," + str(data[3]) + "," + str(data[4]) + "," + str(data[5]) + "," + str(data[6]) 
    return text

def convert(data):
    n = data & 0xffffff
    number =  n | (-(n & 0x400000))
    return number