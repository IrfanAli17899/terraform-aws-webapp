# Define Output variables
output "instance_public_ip" {
  value = module.web_server.instance_public_ip
}

output "elb_dns_name" {
  value = module.web_server.elb_dns_name
}