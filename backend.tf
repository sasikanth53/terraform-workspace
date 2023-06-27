provider "aws" {
  region  = "ap-south-1"
  profile = "tfuser"
}

provider "random" {}

resource "random_integer" "ri" {
  min = 10
  max = 99
}

terraform {
  backend "s3" {
    
    bucket  = "hashtek-terraform-workspace" # Replace with your S3 bucket name
    key     = "statefile/terraform.tfstate"
    region  = "ap-south-1"
  }
}
