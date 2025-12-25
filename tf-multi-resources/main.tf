
locals {
  project = "project-01"
}

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }
}

resource "aws_subnet" "my-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count      = 2
  tags = {
    Name = "${local.project}-subnet-${count.index}"

  }
}

#creating 4 EC2 instance
/*resource "aws_instance" "my-instance" {
  ami           = "ami-00ca570c1b6d79f36"
  instance_type = "t3.micro"
  count         = 4
  subnet_id     = element(aws_subnet.my-subnet[*].id, count.index % length(aws_subnet.my-subnet))
  tags = {
    Name = "${local.project}-instance-${count.index}"
  }
}
#creating 2 EC2 instance one Ubuntu second Linux
resource "aws_instance" "my-instance" {
  count         = length(var.ec2-config)
  ami           = var.ec2-config[count.index].ami
  instance_type = var.ec2-config[count.index].instance_type
  subnet_id = element(aws_subnet.my-subnet[*].id, count.index % length(aws_subnet.my-subnet))
  tags = {
    Name = "${local.project}-instance-${count.index}"

  }
}*/

#FOR EACH LOOP USING MAP
resource "aws_instance" "my-instance" {
  for_each      = var.ec2-map #it gives each.key and each.value
  ami           = each.value.ami
  instance_type = each.value.instance_type
  subnet_id     = element(aws_subnet.my-subnet[*].id, index(keys(var.ec2-map), each.key) % length(aws_subnet.my-subnet))
  tags = {
    Name = "${local.project}-instance-${each.key}"
  }

}

output "aws_subnet_id" {
  value = aws_subnet.my-subnet[0].id

}


