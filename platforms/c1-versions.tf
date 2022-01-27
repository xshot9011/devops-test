# Terraform Block
terraform {
  backend "s3" {
    bucket = "oouzou-state"
    key    = "state/terraform.tfstate"
    region = "ap-southeast-1"
  }
}
