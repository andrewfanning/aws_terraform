##  Command Ref:
#   terraform init - downloads any new plugins
#   terraform apply - initiates terraform script
#   terraform show - shows what is currently deployed
#   terraform destroy - removes infrastructure

## Notes
# Terraform creds stored in environment variables


provider "aws" {}

resource "aws_instance" "example" {
  ami           = "ami-0323c3dd2da7fb37d"
  instance_type = "t2.micro"

provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}
