provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "ljs098u029d-terraform-backend"
    key    = "main.tfstate"
    region = "eu-central-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.2.0"
}
