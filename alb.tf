#Application Load Balancer
resource "aws_alb" "application_load_balancer" {
  name               = "${var.app_name}-${var.app_environment}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = [aws_security_group.hello_world_task.id]

  tags = {
    Name        = "${var.app_name}-alb"
    Environment = var.app_environment
  }
}

#Target Group
resource "aws_lb_target_group" "target_group" {
  name        = "${var.app_name}-${var.app_environment}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc

  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTPS"
    matcher             = "200"
    timeout             = "3"
    path                = "/v1/status"
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "${var.app_name}-lb-tg"
    Environment = var.app_environment
  }
}

#Listener
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.id
  }

  tags = {
    Name        = "${var.app_name}"
    Environment = var.app_environment
  }
}

resource "aws_lb_listener" "listener1" {
  load_balancer_arn = aws_alb.application_load_balancer.id
  port              = "443"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.id
  }
  tags = {
    Name        = "${var.app_name}"
    Environment = var.app_environment
  }
}