
resource "aws_key_pair" "main" {

  depends_on = [aws_subnet.public]
  key_name   = "ec2-instance-ssh-key"
  public_key = file("~/.ssh/id_ed25519.pub")

}