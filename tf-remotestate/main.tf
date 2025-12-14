
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
  backend "s3" {
    bucket = "testbucket001-aws001"
    key = "backend.tfstate"
    region = "ap-south-1"
  }
}
provider "aws" {
  region = "ap-south-1"
 }

  resource "aws_instance" "myserver" {
    ami = "ami-00ca570c1b6d79f36"
    instance_type = "t3.micro"

    tags = {
      Name ="SampleServer"
    }
}