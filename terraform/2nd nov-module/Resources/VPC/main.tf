resource "aws_vpc" "arun" {
  region = var.vpc_region
  cidr_block       = var.vpc_cidr
  tags = {
    Name = var.tag1
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.arun.id
  region = var.vpc_region
  cidr_block = var.vpc_public_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name = var.vpc_public_tag
  }
}
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.arun.id
  region = var.vpc_region
  cidr_block = var.vpc_private_cidr
  availability_zone = "us-east-1c"

  tags = {
    Name = var.vpc_private_tag
  }
}