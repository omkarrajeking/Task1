output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name 
}

output "load_balancer_url" {
  value = aws_lb.app_alb.dns_name
  description = "The URL of the Load Balancer where the ECS service is accessible."
}
