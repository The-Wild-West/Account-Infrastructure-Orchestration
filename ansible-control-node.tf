data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "ansible_control_node" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  user_data     = filebase64("${path.root}/scripts/ansible-control-userdata.sh")

  network_interface {
    network_interface_id = aws_network_interface.primary_network_interface.id
    device_index         = 0
  }
}

resource "aws_network_interface" "primary_network_interface" {
  subnet_id   = aws_subnet.subnet.id
  private_ips = ["10.0.1.10"]

  tags = {
    Name = "primary_network_interface"
  }
}