#!/bin/bash
# Prepares colab linux home folder

# JDownloader
curl -OL "https://github.com/black-eagle-1903/javapub/raw/main/jdownloader.7z.001"
curl -OL "https://github.com/black-eagle-1903/javapub/raw/main/jdownloader.7z.002"
7z x jdownloader.7z.001 -y
rm jdownloader.7z.001 jdownloader.7z.002

# Oracle JDK
wget "https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz"
tar -xvf jdk-17_linux-x64_bin.tar.gz

# Double Commander configuration
curl -OL "https://github.com/black-eagle-1903/javapub/raw/main/doublecmd_config.7z"
7z x doublecmd_config.7z -y
rm doublecmd_config.7z

# Create jdownloader.sh and give execute permision
printf "#!/bin/bash\ncd jdownloader\n"$HOME/$(tar -tf jdk-17_linux-x64_bin.tar.gz|cut -d "/" -f1|sort|uniq)"/bin/java -jar JDownloader.jar">jdownloader.sh
chmod u+x jdownloader.sh
rm jdk-17_linux-x64_bin.tar.gz

# Create an alias for git.sh script
alias g='/home/colab/git.sh'

# Create sleep_loop.sh
echo "#!/bin/bash\nfor i in {1..14400};do echo -e \".\c\"; sleep 3; done">sleep_loop.sh
chmod u+x sleep_loop.sh


