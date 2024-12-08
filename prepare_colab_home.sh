#!/bin/bash
# Prepares colab linux home folder
LATEST_GRAAL_VM_RELEASE_URL='https://github.com/graalvm/graalvm-ce-builds/releases/latest'
LATEST_GRAAL_VM_VERSION=$(basename $(curl -sw "%{redirect_url}" "${LATEST_GRAAL_VM_RELEASE_URL}"))
LATEST_GRAAL_VM_ARCHIVE_URL='https://github.com/graalvm/graalvm-ce-builds/releases/download/'${LATEST_GRAAL_VM_VERSION}'/graalvm-community-'${LATEST_GRAAL_VM_VERSION}'_linux-x64_bin.tar.gz'

# JDownloader
curl -OL "https://github.com/black-eagle-1903/javapub/raw/main/jdownloader.7z.001"
curl -OL "https://github.com/black-eagle-1903/javapub/raw/main/jdownloader.7z.002"
7z x jdownloader.7z.001 -y
rm jdownloader.7z.001 jdownloader.7z.002

# GRAAL VM JDK
wget "${LATEST_GRAAL_VM_ARCHIVE_URL}"
tar -xvf ${LATEST_GRAAL_VM_ARCHIVE_URL##*/}

# Double Commander configuration
curl -OL "https://github.com/black-eagle-1903/javapub/raw/main/doublecmd_config.7z"
7z x doublecmd_config.7z -y
rm doublecmd_config.7z

# Create jdownloader.sh and give execute permision
#printf "#!/bin/bash\ncd jdownloader\n"$HOME/$(tar -tf ${ORACLE_JDK_URL##*/}|cut -d "/" -f1|sort|uniq)"/bin/java -jar JDownloader.jar">jdownloader.sh
printf "#!/bin/bash\ncd jdownloader\n"$HOME/$(tar -tf ${LATEST_GRAAL_VM_ARCHIVE_URL##*/}|head -1|cut -d "/" -f1|sort|uniq)"/bin/java -jar JDownloader.jar">jdownloader.sh
chmod u+x jdownloader.sh
rm ${LATEST_GRAAL_VM_ARCHIVE_URL##*/}

# Create my additional aliases
echo '# My additional aliases'>> ~/.bashrc
echo "alias g='/home/colab/git.sh'">> ~/.bashrc
echo "alias scr='cd /home/colab/shell/colab'">> ~/.bashrc

# Create sleep_loop.sh
echo -e "#!/bin/bash\nfor i in {1..14400};do echo -e \".\c\"; sleep 3; done">sleep_loop.sh
chmod u+x sleep_loop.sh
