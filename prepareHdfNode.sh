#!/bin/bash
# Prepares an EC2 instance for HDF
# CentOS 7.2
# 2016-11-11

echo "*******************************"
echo "Starting"
echo "*******************************"

#Disks
echo "Formatting disks"
sudo mkfs -t ext4 /dev/xvdb
sudo mkfs -t ext4 /dev/xvdc
sudo mkfs -t ext4 /dev/xvdd
sudo mkfs -t ext4 /dev/xvde
sudo mkfs -t ext4 /dev/xvdf

#Move /var/log
echo "Backing up /var/log"
sudo mv /var/log/ /var/log-original

#Create new dirs
echo "Creating /var/log /data0 /data1 /data2 /data3 /data3/dataflow /data3/repo"
sudo mkdir /var/log /data0 /data1 /data2 /data3 /data3/dataflow /data3/repo /opt/HDF /opt/HDF/conf

echo "Backing up /etc/fstab"
sudo cp /etc/fstab /etc/fstab.bak

#Mounts
echo "Adding mount entries to fstab"
sudo sed -i '$ a/dev/xvdb /data0 ext4 defaults,noatime 0 0' /etc/fstab
sudo sed -i '$ a/dev/xvdc /data1 ext4 defaults,noatime 0 0' /etc/fstab
sudo sed -i '$ a/dev/xvdd /data2 ext4 defaults,noatime 0 0' /etc/fstab
sudo sed -i '$ a/dev/xvde /data3 ext4 defaults,noatime 0 0' /etc/fstab
sudo sed -i '$ a/dev/xvdf /var/log ext4 defaults 0 0' /etc/fstab

echo "Mount all entries in fstab"
sudo mount -a

#File Limits
echo "Setting file limits"
sudo sed -i '$ ahdfs - nofile 32768' /etc/security/limits.conf
sudo sed -i '$ ahdfs - nproc 32768' /etc/security/limits.conf
sudo sed -i '$ amapred - nofile 32768' /etc/security/limits.conf
sudo sed -i '$ amapred - nproc 32768' /etc/security/limits.conf
sudo sed -i '$ ahbase - nofile 32768' /etc/security/limits.conf
sudo sed -i '$ ahbase - nproc 32768' /etc/security/limits.conf


#install Java
echo "Install Java 1.8.0"
sudo yum install java-1.8.0-openjdk

#Add nifi user
sudo useradd nifi

#Change ownership of new directory to nifi
sudo chown -R nifi /data0 /data1 /data2 /data3 /opt/HDF

echo "*******************************"
echo "Complete"
echo "*******************************"
