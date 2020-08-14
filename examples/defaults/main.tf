variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  region = var.aws_region
}

resource "random_pet" "this" {
  length = 2
}

module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  name            = random_pet.this.id
  cidr            = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

module "defaults" {
  source       = "../.."
  cluster_name = random_pet.this.id
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.public_subnets
}
