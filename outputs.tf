output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "repository_url"{
  value = module.ecr.repository_url
}

output "load_balancer" {
  value = module.ecs.load_balancer_url
}

output "ecs_security_group"{
    value =  module.vpc.ecs_security_group 
}

