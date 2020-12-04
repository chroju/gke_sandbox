terraform {
  required_version = "~> 0.13.0"

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "chroju"

    workspaces {
      name = "alfred-workflow-sample"
    }
  }

  required_providers {
    aws = {
      version = "~> 2.41.0"
      source  = "hashicorp/aws"
    }
  }

}

provider "aws" {
  region     = "ap-northeast-1"
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

