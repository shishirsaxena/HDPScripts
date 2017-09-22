#!/bin/bash
# Configures an EC2 instance as Master Node
# CentOS 7.2
# 2016-10-31

echo "*******************************"
echo "Starting"
echo "*******************************"

#UMASK
echo "Setting Umask to 022"
sudo sed -i 's/umask 002/umask 022/' /etc/profile

#SELinux
echo "Disabling SELinux"
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

#NTP
echo "Configuring chronyd client"
sudo sed -i 's/^server/#server/g' /etc/chrony.conf
sudo sed -i '$ aserver 10.77.0.85' /etc/chrony.conf
sudo sed -i '$ aallow 10.77.0.85' /etc/chrony.conf

#Disks
echo "Formatting disks"
sudo mkfs -t ext4 /dev/xvdb
sudo mkfs -t ext4 /dev/xvdc
sudo mkfs -t ext4 /dev/xvdd
sudo mkfs -t ext4 /dev/xvde
sudo mkfs -t ext4 /dev/xvdf
sudo mkfs -t ext4 /dev/xvdg

#Move /var/log
echo "Backing up /var/log"
sudo mv /var/log/ /var/log-original

#Create new dirs
echo "Creating /var/log /data0 /data1 /data2 /data3"
sudo mkdir /var/log /data0 /data1 /data2 /data3

echo "Backing up /etc/fstab"
sudo cp /etc/fstab /etc/fstab.bak

#Mounts
#Don't forget to remove any existing mounts on b,c,d,e
#jilia-hadoop-ambari: xvdg and xvdf are reversed
echo "Adding mount entries to fstab"
sudo sed -i 's/^\/dev\/xvdb/#\/dev\/xvdb/' /etc/fstab
sudo sed -i '$ a/dev/xvdb /data0 ext4 defaults,noatime 0 0' /etc/fstab
sudo sed -i '$ a/dev/xvdc /data1 ext4 defaults,noatime 0 0' /etc/fstab
sudo sed -i '$ a/dev/xvdd /data2 ext4 defaults,noatime 0 0' /etc/fstab
sudo sed -i '$ a/dev/xvde /data3 ext4 defaults,noatime 0 0' /etc/fstab
sudo sed -i '$ a/dev/xvdf /mnt ext4 defaults 0 0' /etc/fstab
sudo sed -i '$ a/dev/xvdg /var/log ext4 defaults 0 0' /etc/fstab

echo "Mount all entries in fstab"
sudo mount -a

#Swappiness
echo "Disable swappiness"
sudo systemctl stop tuned
sudo systemctl disable tuned
sudo sed -i '$ avm.swappiness = 1' /etc/sysctl.conf

#Tune2FS
echo "Freeing storage reserved for root user"
sudo tune2fs -m 0 /dev/xvdb
sudo tune2fs -m 0 /dev/xvdc
sudo tune2fs -m 0 /dev/xvdd
sudo tune2fs -m 0 /dev/xvde

#NSCD
echo "Configuring Name Service Cache Daemon"
sudo yum -y install nscd
sudo chkconfig --level 345 nscd on
sudo systemctl start nscd

#File Limits
echo "Setting file limits"
sudo sed -i '$ ahdfs - nofile 32768' /etc/security/limits.conf
sudo sed -i '$ ahdfs - nproc 32768' /etc/security/limits.conf
sudo sed -i '$ amapred - nofile 32768' /etc/security/limits.conf
sudo sed -i '$ amapred - nproc 32768' /etc/security/limits.conf
sudo sed -i '$ ahbase - nofile 32768' /etc/security/limits.conf
sudo sed -i '$ ahbase - nproc 32768' /etc/security/limits.conf

echo "*******************************"
echo "Complete"
echo "*******************************"
