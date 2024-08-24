#!/bin/bash
zrok_latest_release_URL='https://github.com/openziti/zrok/releases/latest'
latest_version=$(basename $(curl -sw "%{redirect_url}" "${zrok_latest_release_URL}"))
zrok_package_URL='https://github.com/openziti/zrok/releases/download/'$latest_version'/zrok_'${latest_version:1}'_linux_amd64.tar.gz'
zrok_secret_token=$1

# 1st argument is zrok secret token
if [ -z "${zrok_secret_token}" ]; then
	echo "Error: zrok secret token is not supplied!"
	exit 1
fi

curl -OL "${zrok_package_URL}"
tar -xvf ./zrok*linux*.tar.gz zrok
rm zrok*linux*.tar.gz
./zrok enable ${zrok_secret_token}
./zrok share private --backend-mode tcpTunnel localhost:5901