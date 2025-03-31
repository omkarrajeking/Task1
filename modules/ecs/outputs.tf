output "ecs_cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "load_balancer_url" {
  value = aws_lb.nginx_lb.dns_name
  description = "The URL of the Load Balancer where the ECS service is accessible."
}
