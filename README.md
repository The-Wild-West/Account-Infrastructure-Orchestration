# Account-Infrastructure-Orchestration
This repository is meant to house are orchestration tools that we will be deploying to our root account.

## Technologies Used
![Screenshot of the Networking Deployed for Ansible Setup](/images/networking-ansible.png)

Terraform is our IaC tool that we will use to deploy all resources into the aws account. We are currently working to setup an ansible control node as an ec2 instance in the root account and allow it to have cross account access to all other accounts. In order to save on cost we will deploy VPC's in all accounts with the necessary subnets and security groups. We will then deploy VPC Peering. All Ansible packages will be downloaded to an S3 Bucket in root to eliminate the need for a NAT Gateway(saving on cost), more to come on this later.
