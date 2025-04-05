output "vpc_id" {
  value = aws_vpc.Task.id
}

output "public_subnets" {
  value = [aws_subnet.sub-1.id, aws_subnet.sub-2.id]
}

output "ecs_security_group"{
    value = [ aws_security_group.ecs_security_group.id ]
}

