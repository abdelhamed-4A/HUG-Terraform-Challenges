locals {
  protocol = var.lb_type == "application" ? "HTTP" : "TCP"
}

resource "aws_lb" "this" {
  count = var.create_module ? 1 : 0

  name               = substr("${var.project_name}-${var.environment}-lb", 0, 32)
  internal           = false
  load_balancer_type = var.lb_type
  subnets            = var.subnet_ids
  security_groups    = var.lb_type == "application" ? var.security_group_ids : null

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-lb"
  })
}

resource "aws_lb_target_group" "this" {
  count = var.create_module ? 1 : 0

  name     = substr("${var.project_name}-${var.environment}-tg", 0, 32)
  port     = 80
  protocol = local.protocol
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    path                = var.lb_type == "application" ? "/" : null
    protocol            = local.protocol
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-tg"
  })
}

resource "aws_lb_listener" "this" {
  count = var.create_module ? 1 : 0

  load_balancer_arn = aws_lb.this[0].arn
  port              = 80
  protocol          = local.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[0].arn
  }
}

resource "aws_lb_target_group_attachment" "this" {
  for_each = var.create_module ? { for idx, id in var.target_instance_ids : idx => id } : {}

  target_group_arn = aws_lb_target_group.this[0].arn
  target_id        = each.value
  port             = 80
}
