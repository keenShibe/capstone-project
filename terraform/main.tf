provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source     = "./modules/vpc"
  vpc_cidr   = var.vpc_cidr
  subnet_cidrs = var.subnet_cidrs
}

module "ecs" {
  source = "./modules/ecs"
  ecs_cluster_name = "google-play-ecs-cluster"
}

module "dynamodb" {
  source = "./modules/dynamodb"
}
