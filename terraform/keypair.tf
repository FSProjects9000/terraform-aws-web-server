
resource "aws_key_pair" "main" {
  key_name   = "ec2-instance-ssh-key"
  public_key = file("~/.ssh/id_ed25519.pub")
  
}