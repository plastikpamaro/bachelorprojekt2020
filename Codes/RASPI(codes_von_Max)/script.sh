#!/bin/bash

# Kill tasks if there are some witch exists before
killall ./lauscher
killall /home/pi/mic_handler_pipe

#set color
Cyan='\033[0;36m'
NC='\033[0m'

clear


echo -e "${Cyan}Start of main script.${NC}"

#start main script
./lauscher &
echo -e "${Cyan}Wait for boot${NC}"
sleep 1

echo -e "${Cyan}Start of microphone script.${NC}"

#start script wich handles communication tith the micropones and sends it over the pipe
/home/pi/mic_handler_pipe &
