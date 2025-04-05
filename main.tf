module "vpc"{
  source = "./modules/vpc"
}

module "ecr" {
  source          = "./modules/ecr"

}



module "ecs" {
  source = "./modules/ecs"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
  security_group_ids = module.vpc.ecs_security_group
}



