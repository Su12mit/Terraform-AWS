//Variable declaration
variable "region"{
  description = "It is region declaration"
  type = string
  default = "ap-south-1"
}
//variable end
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
  //rgion = var.region //Variable value use
}
  resource "aws_instance" "myserver" {
    ami = "ami-00ca570c1b6d79f36"
    instance_type = "t3.micro"

    tags = {
      Name ="SampleServer"
    }
}