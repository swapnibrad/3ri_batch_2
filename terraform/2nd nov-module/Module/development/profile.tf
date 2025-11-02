provider "aws" {
  region     = "us-west-1"
  profile = "tf-user"
  default_tags {
   tags = {
     Environment = "Test"
   }
 }
}

# terraform command