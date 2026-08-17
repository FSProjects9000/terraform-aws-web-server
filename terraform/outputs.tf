output "public_ip" {
  description = "Public IP address of the EC2 instance"

  value = aws_instance.webserver.public_ip
}

output "vpc_id" {

  description = "VPC ID"

  value = aws_vpc.main.id

}

output "subnet_id" {
  description = "SUBNET ID"

  value = aws_subnet.public.id
}

output "security_group_id" {

  value = aws_security_group.web.id

}

output "instance_id" {
  description = "id of the EC2 instance"

  value = aws_instance.webserver.id
}
