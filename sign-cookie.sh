#!/bin/bash

AMI_ID="ami-078829174439aee2c"
declare -a BACKEND_IPS=($(aws ec2 describe-instances --filters "Name=image-id,Values=$AMI_ID" "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[*].[InstanceId, PublicIpAddress]' --output text | sort | cut -f2))
echo "Found Eureka backend IPs (${#BACKEND_IPS[@]}): ${BACKEND_IPS[@]}"

(
    N=${#BACKEND_IPS[@]}
    for J in $(seq 0 $(($N-1)) ); do
        cookiecutter -k $(dirname $0)/fakekey.pem  -s ${BACKEND_IPS[$J]}  -u /proxy/$(($J+1))of${N}/localhost:5873/yfcc100m_simple/scope
    done;
) > $HOME/.diamond/NEWSCOPE

echo "Generated cookie :-)"