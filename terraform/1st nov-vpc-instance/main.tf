resource "aws_vpc" "batch3" {
  cidr_block       = var.vpc_cidr
  tags = {
    Name = var.tag1
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.batch3.id
  cidr_block = var.vpc_public_cidr
  availability_zone = "us-west-1a"

  tags = {
    Name = var.vpc_public_tag
  }
}
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.batch3.id
  cidr_block = var.vpc_private_cidr
  availability_zone = "us-west-1c"

  tags = {
    Name = var.vpc_private_tag
  }
}
# create IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.batch3.id
  tags = {
    Name = var.vpc_igw_tag
  }
}

# # attach IGW to  vpc
# resource "aws_internet_gateway_attachment" "example" {
#   internet_gateway_id = aws_internet_gateway.igw.id
#   vpc_id              = aws_vpc.batch3.id
# }

# attach IGW to default router #default_route_table_id
resource "aws_route" "default_internet_route" {
  route_table_id         = aws_vpc.batch3.default_route_table_id 
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on = [aws_vpc.batch3,aws_internet_gateway.igw]
}

#subnet associate in default router
resource "aws_route_table_association" "public_subnet_association" {
      subnet_id      = aws_subnet.public.id
      route_table_id = aws_vpc.batch3.default_route_table_id
    }

# create instance on public subnet
resource "aws_instance" "public_instance" {
  ami           = var.ami
  instance_type = var.i-type
  tags = {
    Name = "terraform_dev_public_instance",
    Team = "Devops-1",
 Project = "3ri"
  }
  subnet_id     = aws_subnet.public.id
disable_api_termination = var.api-termn
iam_instance_profile = var.role
key_name = var.key
}

# create instance on private subnet