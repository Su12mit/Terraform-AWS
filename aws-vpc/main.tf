terraform {
  required_providers {
    aws={
        source = "hashicorp/aws"
        version = "5.54.1"
    }
  }
}

provider "aws" {
  region = "ap-south-1"

}

#create a VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name="my-vpc"
  }
}

#create a private subnet in the VPC
resource "aws_subnet" "my-vpc-privatesubnet"{
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      name="private-myvpc-subnet"
    }
}

#create a public subnet in the VPC
resource "aws_subnet" "my-vpc-publicsubnet"{
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      name="public-myvpc-subnet"
    }
}

#create a internet gateway in the VPC
resource "aws_internet_gateway" "my-vpc-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    name="my-vpc-igw"
  }
}

#create a route table in the VPC
resource "aws_route_table" "my-vpc-routetable" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-vpc-igw.id
  }
  tags = {
    name="my-vpc-routetable"
  }
}

#create a route table association in the VPC for public subnet
resource "aws_route_table_association" "public-subnet" {
  route_table_id = aws_route_table.my-vpc-routetable.id
  subnet_id = aws_subnet.my-vpc-publicsubnet.id
}

#create a route table association in the VPC for private subnet 
resource "aws_route_table_association" "private-subnet" {
  route_table_id = aws_route_table.my-vpc-routetable.id
  subnet_id = aws_subnet.my-vpc-privatesubnet.id
}
