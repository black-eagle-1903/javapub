#!/bin/bash
# Corrects xServer authentication of colab linux user and calls vncconfig

xauth list > /tmp/xauth
chmod a+r /tmp/xauth
runuser -l colab -c 'while read line;do xauth add $line;done</tmp/xauth'
vncconfig &
