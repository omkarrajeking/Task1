resource "aws_ecr_repository" "ecr_repository" {
  name = var.repository_name
  tags = {
    name  = var.repository_name
  }
}

