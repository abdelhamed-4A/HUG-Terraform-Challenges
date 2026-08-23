terraform {
  backend "s3" {
    bucket       = "hug-terraform-bucket-state"
    key          = "week-1/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
