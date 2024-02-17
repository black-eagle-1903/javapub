#!/bin/bash
# Installs TightVNC server and ngrok; then start the service and tunnel respectively.
# The following 2 input arguments should be supplied:
#	1st argument	: ngrok auth string
#	2nd argument	: VNC password
# v1.0

NGROK_AUTH=$1
VNC_PWD=$2
VNC_GEOMETRY='1916x980'
NGROK_DOWNLOAD_URL='https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz'
NGROK_LOCAL_API_URL='http://localhost:4040/api/tunnels'

# Check the existence of the input argument
# 1st argument is the arguments value, 2nd argument is the error message if it is not supplied
# and 3rd argument is the exit code
function check_input_argument
{
if [ -z "$1" ]; then
	echo "Error: "$2" is not supplied!" 
	exit $3
fi
}

check_input_argument "${NGROK_AUTH}" "ngrok auth string" 1
check_input_argument "${VNC_PWD}" "VNC password" 2

apt-get update
apt-get install xfce4 xfce4-goodies xfce4-terminal xfonts-base xfonts-75dpi xfonts-100dpi
apt-get install tightvncserver

update-alternatives --set x-terminal-emulator /usr/bin/xfce4-terminal.wrapper

mkdir -p ~/.vnc
printf "#!/bin/bash\nstartxfce4 &" >  ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

# set VNC password
echo -e ${VNC_PWD}"\n"${VNC_PWD}"\n\n" | vncpasswd

USER=root;HOME=/root;export USER HOME; vncserver -geometry ${VNC_GEOMETRY}

# Download, unzip and remove ngrok stable zip file
wget -q -c -nc ${NGROK_DOWNLOAD_URL}
tar zxvf ${NGROK_DOWNLOAD_URL##*/}
rm ${NGROK_DOWNLOAD_URL##*/}

# Start ngrok tunnel
./ngrok authtoken $NGROK_AUTH
./ngrok tcp 5901 &

curl ${NGROK_LOCAL_API_URL}
