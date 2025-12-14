terraform {
  required_providers {
    aws={
        source = "hashicorp/aws"
        version = "5.54.1"
    }
    //using random provider
     random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}
//random id generation
resource "random_id" "ran_id" {
  byte_length = 8
}
//bucket creation
resource "aws_s3_bucket" "testbucket" {
  bucket = "testbucket001-aws001" //For unique name & ID => "Demo-bucket-${random_id.ran_id.hex}"
}
//bucket object creation
resource "aws_s3_object" "mefile001" {
  source = "./myfile.txt"
  bucket = aws_s3_bucket.testbucket.bucket
  key = "mydata.txt"
}
