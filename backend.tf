terraform {
  backend "s3" {
    bucket       = "asg-task-terraform-bucket"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true   
  }
}
