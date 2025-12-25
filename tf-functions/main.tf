terraform {
  
}
locals {
  value="Hello world"
}

variable "string_list" {
  type = list(string)
  default = [ "serv1","serv2","serv3", "serv1" ]
}

output "output" {
  #value = lower(local.value)
  #value=upper(local.value)
  #value = startswith(local.value, "Hello")
  #value = split(" ",local.value)
  #value = max(1,2,3,4,5)
  #value = min(1,2,3,4,5)
  #value = abs(-15.123)
  #value = length(var.string_list)
  #value = join(":",var.string_list)
  #value = contains(var.string_list,"serv1")
  value = toset(var.string_list)
}
