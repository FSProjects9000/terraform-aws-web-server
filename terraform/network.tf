terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">6.0"
        }
    }
}

provider "aws"{
    region = "eu-west-3"
}


 # Resource blocks declare a resource type and name. 
 # Together, the type and name form a resource identifier (ID)
 # in the format resource_type.resource_name, 
 # in this case aws_vpn.example

 # Resource types always start with the provider name followed by an 
 # underscore. The aws_vpc resource type belongs to the aws provider

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
}