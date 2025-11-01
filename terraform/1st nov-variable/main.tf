resource "aws_instance" "tf_i_1" {
  ami           = var.ami
  count = 2
  instance_type = var.i-type
  region = var.region.0
  tags = {
    Name = "terraform_dev_261025",
    Team = "Devops-1",
 Project = "3ri"
  }
availability_zone = var.az
disable_api_termination = var.api-termn
iam_instance_profile = var.role
key_name = var.key
user_data = <<EOF
   #!/bin/bash
  sudo yum update 
  sudo yum install httpd -y
  systemctl start httpd
  systemctl enable httpd
  mkdir /var/www/html/training
  echo "welcome to Job & placement-oriented-training page: "  >> /var/www/html/training/index.html
  hostname >> /var/www/html/training/index.html
  EOF
  }






























##########  Practice  ########
# resource "aws_iam_user" "tf_user" {
# name = var.user1
# }