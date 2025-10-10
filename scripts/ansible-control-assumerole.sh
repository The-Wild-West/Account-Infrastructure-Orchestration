role=$(aws sts assume-role --role-arn "arn:aws:iam::856364870650:role/ansible_cross_account_role" --role-session-name "Ansible-Control-Session")
export AWS_ACCESS_KEY_ID=$(echo $role | jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(echo $role | jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(echo $role | jq -r '.Credentials.SessionToken')
export AWS_DEFAULT_REGION=us-east-1