#!/bin/bash
# Bash script for launching JDownloader

cd jdownloader
# tar -tf jdk-17_linux-x64_bin.tar.gz|cut -d "/" -f1|sort|uniq
# This command obtains the extracted JDK path dynamically
"$HOME/$(tar -tf jdk-17_linux-x64_bin.tar.gz|cut -d "/" -f1|sort|uniq)"/bin/java -jar JDownloader.jar
