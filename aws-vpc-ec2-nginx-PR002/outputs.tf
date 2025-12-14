//output declaration 
output "instance_public_ip" {
  value = aws_instance.nginxserver.public_ip
}

output "instance_url" {
  description = "The URL to access thr nginx server"
  value = "http://${aws_instance.nginxserver.public_ip}"
}