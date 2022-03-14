#!/bin/bash
# Invokes Double Commander for desktop launcher

# If colab user home folder has not .Xauthority file authorize colab user
if [ ! -f "/home/colab/.Xauthority" ]; then
	xauth list > /tmp/xauth
	chmod a+r /tmp/xauth
	runuser -l colab -c 'while read line;do xauth add $line;done</tmp/xauth'
fi

echo doublecmd|su - colab
