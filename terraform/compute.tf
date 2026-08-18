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

resource "aws_instance" "webserver" {
  user_data            = file("${path.module}/user-data.sh")
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = "t3.micro"
  subnet_id            = aws_subnet.public.id
  key_name             = aws_key_pair.main.key_name
  vpc_security_group_ids = [
    aws_security_group.web.id
  ]
  tags = {
    Name = "webserver"
    PatchGroup = "production"
  }
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "ec2_ssm_profile"
  role = aws_iam_role.ec2_role.name
}
