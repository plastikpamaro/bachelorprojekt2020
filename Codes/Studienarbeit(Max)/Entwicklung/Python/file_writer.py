class file_writer():
    def __init__(self,path_to_file="./test.csv"):
        self.file = open(path_to_file,'w')
    
    def __del__(self):
        self.file.close()

    def write_line(self, text):
        self.file.write(text + "\n")
    
if __name__ == "__main__":
    file = file_writer()
    file.write_line("Hallo Welt!")
    file.write_line("Guten Tag")
