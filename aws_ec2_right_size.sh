#!/bin/bash
#set -x
PWD="${HOME}/Ec2_Right_Size"

missing_vars () {
  echo;
  echo "Please supply a proper actions";
  echo;
  echo "Usage: ./cost-optimizaton.sh [aws_use1_prod|aws_use1_qa|aws_usw2_qa|aws_usw2_prod] [ec2-resize] ";
  echo;
  echo "Example: ./aws_ec2_right_size.sh aws_usw2_qa ec2-resize ";
  echo;
  exit 1;
}

if [ -z "${1}" ] || [ -z "${2}" ]; then
  missing_vars;
fi

case $1 in
  aws_use1_prod )  
    REGION="us-east-1";
    HOSTS="aws_use1_prod";
    ;;
  aws_use1_qa )
    REGION="us-east-1";
    HOSTS="aws_use1_qa";
    ;;
  aws_usw2_prod )
    REGION="us-west-2";
    HOSTS="aws_usw2_prod";
    ;;
  aws_usw2_qa )
    REGION="us-west-2";
    HOSTS="aws_usw2_qa";
    ;;
  * )
    missing_vars;
    ;;
esac

case $2 in
  ec2-resize )
    sed -i "s/hosts: .*/hosts: ${HOSTS}/g" ${PWD}/resize-ec2.yaml
    sed -i "s/REGION: .*/REGION: ${REGION}/g" ${PWD}/resize-ec2.yaml
    ansible-playbook -i ${PWD}/hosts.ini --vault-password-file=${PWD}/vault_password.txt ${PWD}/resize-ec2.yaml -vvvv
    ;;
  * )
    missing_vars;
    ;;
esac