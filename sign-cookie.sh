#!/bin/bash

BACKEND_IPS=($(aws ec2 describe-instances --filters "Name=tag:purpose,Values=edu.cmu.cs.eureka" "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[*].[InstanceId, PublicIpAddress]' --output text | sort | cut -f2))
echo "Found Eureka backend IPs (${#BACKEND_IPS[@]}): ${BACKEND_IPS[@]}"

(
    N=${#BACKEND_IPS[@]}
    for J in $(seq 0 $(($N-1)) ); do
        cookiecutter -k $(dirname $0)/fakekey.pem  -s ${BACKEND_IPS[$J]}  -u /proxy/$(($J+1))of${N}/localhost:5873/yfcc100m_simple/scope
    done;
) > $HOME/.diamond/NEWSCOPE

echo "Generated cookie :-)"