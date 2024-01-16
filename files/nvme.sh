#!/bin/bash

os_version=$(lsb_release -rs)

#Taking backup of /etc/fstab 
cp /etc/fstab /etc/fstab.bak

#install nvme-cli
sudo apt-get install nvme-cli

#Get 999-aws-ebs-nvme.rules file
wget 
sudo cp -v 999-aws-ebs-nvme.rules /etc/udev/rules.d/

#Get ebs-nvme-mapping.sh file
wget 
sudo cp ebs-nvme-mapping.sh /usr/local/sbin/
chmod 755 /usr/local/sbin/ebs-nvme-mapping.sh

#Modifying fstab file
#This configuration is for ubuntu 18.04 version and it may vary from your setup. Kindly modify the fstab changes accordingly.
if [ "$os_version" == "18.04" ]; then
	if grep -q '/dev/xvdf' /etc/fstab; then
		sed -i 's,/dev/xvdf,#/dev/xvdf,' /etc/fstab
		echo 'UUID=xxxx-xxx-xxx-xxxx    /data    xfs    defaults    0 0' >> /etc/fstab
	fi
else
	echo "Unsupported Ubuntu version: $os_version"
fi