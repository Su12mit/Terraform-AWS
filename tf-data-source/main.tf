terraform {
  required_providers {
    aws={
        source = "hashicorp/aws"
        version = "5.54.0"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
}

#data source
data "aws_ami" "name" {
  most_recent = true
  owners = ["amazon"] 
}

#security group
data "aws_security_group" "name" {
  tags = {
    Linux_SG = "http"
  }
}

#vpc ID
data "aws_vpc" "name" {
  tags = {
    name="my-vpc"
  }
}

#AZ
data "aws_availability_zone" "name" {
  state = "available"
}

#to get account details
data "aws_caller_identity" "name" {
    
}

#region
data "aws_region" "name" {
  
}

output "region_name" {
  value = data.aws_region.name
}
output "caller_info" {
  value = data.aws_caller_identity.name
}

output "aws_security_group" {
  value = data.aws_security_group.name.id
}

output "aws_ami" {
  value = data.aws_ami.name
}

output "vpc_id" {
  value = data.aws_vpc.name.id
}
output "aws_zones" {
  value = data.aws_availability_zone.name
}
#resource
resource "aws_instance" "myserver" {
    ami = "ami-00ca570c1b6d79f36"
    instance_type = "t3.micro"

    tags = {
      Name ="SampleServer"
    }
}