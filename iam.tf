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