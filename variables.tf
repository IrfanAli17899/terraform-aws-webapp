
# Define Variables
variable "region" {
  type    = string
  default = "us-west-2"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami" {
  type    = string
  default = "ami-0c55b159cbfafe1f0"
}

variable "key_name" {
  type    = string
  default = "my_ssh_key"
}

# # Define Output variables
# output "instance_public_ip" {
#   value = module.web_server.instance_public_ip
# }