data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-2297"
    key    = "terraform-mutable/vpc/${var.env}/terraform.tfstate"
    region = "us-east-1"
   }
}
