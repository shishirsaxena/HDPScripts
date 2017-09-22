#!/bin/bash
privateKey="$1"

for i in $(cat hosts)
do
        echo "=== ${i} ==="
        ssh -t -oStrictHostKeyChecking=no -i $privateKey ec2-user@${i} "hostname -f";
        scp -oStrictHostKeyChecking=no -i $privateKey /etc/hosts ec2-user@${i}:hosts
        ssh -t -oStrictHostKeyChecking=no -i $privateKey ec2-user@${i} "sudo cp /etc/hosts /etc/hosts.bak; sudo cp ~/hosts /etc/hosts";
done

