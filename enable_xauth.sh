# If input user's home folder has not .Xauthority file authorize the user
USER_NAME=$1
if [ -z "${USER_NAME}" ]; then
	echo "Error: user name is not supplied!" 
	exit 1
fi
if [ ! -f "/home/${USER_NAME}/.Xauthority" ]; then
	xauth list > /tmp/xauth
	chmod a+r /tmp/xauth
	runuser -l ${USER_NAME} -c 'while read line;do xauth add $line;done</tmp/xauth'
fi
