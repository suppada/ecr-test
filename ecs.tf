#ECS Cluster
resource "aws_ecs_cluster" "ecs" {
  name = "${var.app_name}-${var.app_environment}-cluster"
  tags = {
    Name        = "${var.app_name}-ecs"
    Environment = var.app_environment
  }
}

#ECS Service
resource "aws_ecs_service" "hello_world" {
  name            = "hello-world-service"
  cluster         = aws_ecs_cluster.ecs.id
  task_definition = aws_ecs_task_definition.ecs.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.hello_world_task.id]
    subnets         = var.subnets
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.id
    container_name   = "hello-world-app"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.listener]

  tags = {
    Name        = "${var.app_name}"
    Environment = var.app_environment
  }
}