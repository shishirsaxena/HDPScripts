#!/bin/bash
#Deploys prepareDataNode script on all nodes in data-nodes.txt

echo "Copying prepareDataNode.sh to nodes"
pscp -v -l centos -h data-nodes.txt -x " -oStrictHostKeyChecking=no -i ~/.ssh/jilia-hadoop2.pem" prepareDataNode.sh /home/centos/prepareDataNode.sh

echo "Starting prepareDataNode.sh on each node"
pssh -v -t 0 -l centos -h data-nodes.txt -x "-t -t -oStrictHostKeyChecking=no -i ~/.ssh/jilia-hadoop2.pem" 'chmod +x prepareDataNode.sh && ./prepareDataNode.sh >> prepareDataNode.log && sudo reboot now'