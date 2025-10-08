resource "aws_iam_instance_profile" "ansible-control-iam-profile" {
name = "ansible_control_profile"
role = aws_iam_role.ansible-control-iam-role.name
}

resource "aws_iam_role" "ansible-control-iam-role" {
name        = "ansible-control-node-role"
assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": {
"Effect": "Allow",
"Principal": {"Service": "ec2.amazonaws.com"},
"Action": "sts:AssumeRole"
}
}
EOF
}

resource "aws_iam_role_policy_attachment" "ansible-control-ssm-policy" {
role       = aws_iam_role.ansible-control-iam-role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_policy" "ansible-cross-account-policy" {
name = "ansible-cross-account-policy"
policy = jsonencode({
Version = "2012-10-17"
Statement = [
{
Effect = "Allow"
Action = "sts:AssumeRole"
Resource = [
    "arn:aws:iam::856364870650:role/ansible_cross_account_role",
    "arn:aws:iam::110753343434:role/ansible_cross_account_role",
    "arn:aws:iam::884038419991:role/ansible_cross_account_role"
    
    ]
}
]
})
}

resource "aws_iam_role_policy_attachment" "ansible-cross-account-attachment" {
role       = aws_iam_role.ansible-control-iam-role.name
policy_arn = aws_iam_policy.ansible-cross-account-policy.arn
}