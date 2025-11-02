# create instance on public subnet
resource "aws_instance" "public_instance" {
  ami           = var.ami
  instance_type = var.i-type
  tags = {
    Name = "terraform_dev_public_instance",
    Team = "Devops-1",
 Project = "3ri"
  }
subnet_id     = var.vpc_public_id
disable_api_termination = var.api-termn
iam_instance_profile = var.role
key_name = var.key
region = var.ec2_region
}