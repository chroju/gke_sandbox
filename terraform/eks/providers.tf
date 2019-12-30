provider "aws" {
  version = "~> 2.41.0"
  region  = "ap-northeast-1"
}

terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "chroju"

    workspaces {
      name = "eks_sandbox"
    }
  }
}
