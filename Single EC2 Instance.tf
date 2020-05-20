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

connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/SiriusAWSKeys.pem")
    host        = self.public_ip
}

provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }

provisioner "remote-exec" {
    inline = [
        "sudo yum update -y",
        "sudo yum install httpd -y",
        "service httpd start",
        "chkconfig httpd on",
        "echo "<html><h1>Welcome To My Webpage on Web01</h1></html>" > index.html",
  ]
}
}
