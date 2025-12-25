ec2-config = [{
  ami           = "ami-02b8269d5e85954ef" #ubuntu
  instance_type = "t3.micro"
  }, {
  ami           = "ami-00ca570c1b6d79f36" #Linux
  instance_type = "t3.micro"
}]

ec2-map = {
  "ubuntu" = {
    ami           = "ami-02b8269d5e85954ef"
    instance_type = "t3.micro"
  },
  "Linux" = {
    ami           = "ami-00ca570c1b6d79f36"
    instance_type = "t3.micro"
  }

}