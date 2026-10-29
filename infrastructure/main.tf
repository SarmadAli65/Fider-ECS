module "ecr" {
  source = "./modules/ecr"
}

module "vpc" {
  source = "./modules/vpc"
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_id
  
}

module "ecs" {
  source = "./modules/ecs"
  
  vpc_id = module.vpc.vpc_id
  private_subnet_id = module.vpc.private_subnet_id
  alb_sg_id = module.alb.fider-alb-sg
  alb_tg_arn = module.alb.fider-alb-tg
  JWT_SECRET = module.parameters.JWT_SECRET
  BASE_URL = module.parameters.BASE_URL
  DATABASE_URL = module.parameters.DATABASE_URL
  GO_ENV = module.parameters.GO_ENV
  EMAIL_NOREPLY = module.parameters.EMAIL_NOREPLY
  SECRET_ACCESS_KEY = module.parameters.SECRET_ACCESS_KEY
  ACCESS_KEY = module.parameters.ACCESS_KEY

}

module "rds" {
  source = "./modules/rds"
  vpc_id = module.vpc.vpc_id
  ecs_sg_id = module.ecs.ecs_sg_id
  private_subnet_ids = module.vpc.private_subnet_id
  db_username = var.db_username
  db_password = var.db_password

}

module "ses" {
  source = "./modules/ses"
  verified_email = var.verified_email
}

module "parameters" {
  source = "./modules/parameters"
  base_url = module.alb.fider-alb-dns_name
  JWT_SECRET = var.JWT_SECRET
  db_name = module.rds.db_name
  db_endpoint = module.rds.db_endpoint
  db_username = var.db_username
  db_password = var.db_password
  access_key = module.ses.iam_access_key
  secret_access_key = module.ses.iam_secret_access_key
  email_noreply = var.email_noreply
}

import {
  to = module.ecr.aws_ecr_repository.fider-ecs
  id = "fider-ecs" # The actual name of the repository in AWS
}


