
# --------------------------
#  Application Load Balancer
# --------------------------
resource "aws_lb" "app_alb" {
  name               = "nginx-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids # Replace with your public subnet IDs

  enable_deletion_protection = false

  tags = {
    Name = "nginx-alb"
  }
}

# --------------------------
# 3. Target Group
# --------------------------
resource "aws_lb_target_group" "nginx_tg" {
  name     = "nginx-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id # Replace with your VPC ID

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }

  tags = {
    Name = "nginx-target-group"
  }
}

# --------------------------
# 4. Listener
# --------------------------
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_tg.arn
  }
}




data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/kernel-5.10/recommended/image_id"
}

resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_launch_template" "ecs_lt" {
  name_prefix   = "ecs-launch-template-"
  image_id      = data.aws_ssm_parameter.ecs_ami.value
  instance_type = "t2.micro"
  key_name      = "nginx"

  iam_instance_profile {
    arn = "arn:aws:iam::585768142561:instance-profile/ecsInstanceRole"
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    device_index                = 0
    security_groups             = var.security_group_ids
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 50
    }
  }

  user_data = base64encode("#!/bin/bash\necho ECS_CLUSTER=${var.ecs_cluster_name} >> /etc/ecs/ecs.config")
}

resource "aws_autoscaling_group" "ecs_asg" {
  desired_capacity     = 1
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = var.subnet_ids
  launch_template {
    id      = aws_launch_template.ecs_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ECS Instance - ${var.ecs_cluster_name}"
    propagate_at_launch = true
  }
}

resource "aws_ecs_capacity_provider" "asg_cp" {
  name = "asg-capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs_asg.arn
    managed_scaling {
      status          = "ENABLED"
      target_capacity = 100
    }
    managed_termination_protection = "DISABLED"
  }
}

resource "aws_ecs_cluster_capacity_providers" "cluster_cp_assoc" {
  cluster_name = aws_ecs_cluster.main.name

  capacity_providers = [
    "FARGATE",
    "FARGATE_SPOT",
    aws_ecs_capacity_provider.asg_cp.name
  ]

  default_capacity_provider_strategy {
    base              = 0
    weight            = 1
    capacity_provider = aws_ecs_capacity_provider.asg_cp.name
  }
}

# output "ecs_cluster_name" {
#   value = aws_ecs_cluster.main.name
# }

resource "aws_ecs_task_definition" "nginx_task" {
    family                   = "Taskssss"
  requires_compatibilities = ["EC2"]
  network_mode            = "bridge"
  cpu                     = "1024"
  memory                  = "512"
  execution_role_arn      = "arn:aws:iam::585768142561:role/ecsTaskExecutionRole"
  task_role_arn           = "arn:aws:iam::585768142561:role/ecsTaskExecutionRole"
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "585768142561.dkr.ecr.ap-south-1.amazonaws.com/privaterepoomkar:latest"
      essential = true
      cpu       = 0
      portMappings = [
        {
          containerPort = 80
          hostPort      = 3000
          protocol      = "tcp"
          name          = "nginx-80-tcp"
          appProtocol   = "http"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/Taskssss-2"
          awslogs-region        = "ap-south-1"
          awslogs-stream-prefix = "ecs"
          awslogs-create-group  = "true"
          mode                  = "non-blocking"
          max-buffer-size       = "25m"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "nginx_service" {
  name            = "nginx-service-1-2-3-4"
  cluster         = aws_ecs_cluster.main.id     # Replace with actual ECS cluster reference
  task_definition = aws_ecs_task_definition.nginx_task.arn  # Replace with actual task definition reference
  launch_type     = "EC2"
  desired_count   = 1
  scheduling_strategy = "REPLICA"

  deployment_controller {
    type = "ECS"
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  load_balancer {
    target_group_arn = aws_lb_target_group.nginx_tg.id
    container_name   = "nginx"
    container_port   = 80
  }

  # placement_strategy {
  #   type  = "spread"
  #   field = "attribute:ecs.availability-zone"
  # }

  # placement_strategy {
  #   type  = "spread"
  #   field = "instanceId"
  # }

  enable_ecs_managed_tags = true
}









variable "cpu_threshold" {
  description = "CPU threshold for CloudWatch alarm"
  type        = number
  default     = 80
}
################################################################################################3
# CPU Utilization Alarm for ECS Service
resource "aws_cloudwatch_metric_alarm" "ecs_cpu_alarm" {
  alarm_name          = "Cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.cpu_threshold
  alarm_description   = "Alarm when CPU exceeds ${var.cpu_threshold}%"

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.nginx_service.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_up.arn]

  tags = {
    Name = "Cpu-alarm"
  }
}

# Memory Utilization Alarm for ECS Service
resource "aws_cloudwatch_metric_alarm" "ecs_memory_alarm" {
  alarm_name          = "Memory-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Alarm when Memory exceeds 80%"

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.nginx_service.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_up.arn]

  tags = {
    Name = "Memory-alarm"
  }
}

# Dashboard for ECS Monitoring
resource "aws_cloudwatch_dashboard" "ecs_dashboard" {
  dashboard_name = "Nginx-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/ECS", "CPUUtilization", "ClusterName", aws_ecs_cluster.main.name , "ServiceName", aws_ecs_service.nginx_service.name]
          ]
          period = 300
          stat   = "Average"
          region = "ap-south-1"
          title  = "ECS CPU Utilization"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/ECS", "MemoryUtilization", "ClusterName", aws_ecs_cluster.main.name , "ServiceName", aws_ecs_service.nginx_service.name]
          ]
          period = 300
          stat   = "Average"
          region = "ap-south-1"
          title  = "ECS Memory Utilization"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 24
        height = 6
        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "AutoScalingGroupName", aws_autoscaling_group.ecs_asg.name ]
          ]
          period = 300
          stat   = "Average"
          region = "ap-south-1"
          title  = "EC2 CPU Utilization"
        }
      }
    ]
  })
}

# Auto Scaling Policies
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale-up"
  autoscaling_group_name = aws_autoscaling_group.ecs_asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale-down"
  autoscaling_group_name = aws_autoscaling_group.ecs_asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 300
}

# Scale down alarm
resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "cpu-min"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 3
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 20
  alarm_description   = "Scale down when CPU is low"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ecs_asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_down.arn]

  tags = {
    Name = "cpu-min"
  }
}