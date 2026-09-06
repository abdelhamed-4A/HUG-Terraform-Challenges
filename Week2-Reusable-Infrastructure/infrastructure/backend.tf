terraform {
  backend "s3" {
    bucket         = "hug-terraform-bucket-state"
    key            = "week-2/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    use_lockfile   = true
  }
}
