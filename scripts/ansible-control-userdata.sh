#! /bin/bash

#Install Ansible
sudo apt update
sudo apt install -y software-properties-common unzip
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt update
sudo apt install -y ansible unzip
sudo apt install -y jq

#Register with SSM
sudo mkdir /temp/ssm
cd /temp/ssm
wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
sudo dpkg -i amazon-ssm-agent.deb
sudo systemctl enable amazon-ssm-agent
rm amazon-ssm-agent.deb

#Install AWS CLI
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install
sudo rm -rf aws awscliv2.zip

#Install Python dependencies
sudo apt install -y python3-pip
pip3 install boto3 botocore

#Install Ansible collections
sudo ansible-galaxy collection install amazon.aws