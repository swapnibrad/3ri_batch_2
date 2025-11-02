module "tf_vpc_module" {
  source  = "../../Resources/VPC"
  vpc_cidr = "192.158.0.0/16"
  tag1 = "batch2-tf-vpc-021125"
  vpc_region = "us-east-1"
  vpc_public_cidr = "192.158.0.0/24"
vpc_private_cidr = "192.158.1.0/24"
vpc_private_tag = "private-subnet-1"
vpc_public_tag = "public-subnet-1"
}

module "tf_ec2_module" {
source  = "../../Resources/EC2"
ami = "ami-0bdd88bd06d16ba03"
i-type = "t3.micro"
api-termn = "false"
role = "ec2-role"
key = "delete_user3_nv"
vpc_public_id = module.tf_vpc_module.vpc_public_sub_id
ec2_region = "us-east-1"
}