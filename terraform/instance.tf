resource "aws_instance" "tf_i_1" {
  ami           = "ami-0807bd3aff0ae7273"
  count = 3
  instance_type = "t2.micro"
  region = "us-east-2"
  tags = {
    Name = "terraform_dev_261025",
    Team = "Devops-1",
 Project = "3ri"
  }
availability_zone = "us-east-2a"
disable_api_termination = "true"
iam_instance_profile = "ec2-role"
key_name = "delete_ohio_prashant"
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
