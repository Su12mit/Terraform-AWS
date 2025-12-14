  resource "aws_instance" "nginxserver" {
    ami = "ami-00ca570c1b6d79f36"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.my-vpc-publicsubnet.id
    vpc_security_group_ids = [ aws_security_group.nginxSG.id ]
    associate_public_ip_address = true

    #user date
    user_data = <<-EOF
    #!/bin/bash
    yum update -y
    sudo yum install nginx -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
    EOF
 
    tags = {
      Name ="nginxserver"
    }
}