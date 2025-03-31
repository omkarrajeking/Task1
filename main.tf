module "vpc"{
  source = "./modules/vpc"
}


module "ecr" {
  source = "./modules/ecr"
}

# module "ecs" {
#   source             = "./modules/ecs"
#   cluster_name       = "nginx-cluster"
#   ecr_repository_url = "585768142561.dkr.ecr.ap-south-1.amazonaws.com/task-repo-project:latest"
#   subnet_ids         = ["subnet-0058100fe7a42bb20" , "subnet-0f5c0cebdd3eccb53"]  # Corrected
#   vpc_id             = "vpc-056895d4b177cc7df"          # Corrected
#   security_group_id  = "sg-00a1482f9e9149b99"  # Ensure output exists in vpc module
# }

module "ecs" {
  source = "./modules/ecs"
  cluster_name = "nginx-cluster"
  ecr_repository_url = module.ecr.repository_url
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
  security_group_id  = var.new_security_group_id
}



