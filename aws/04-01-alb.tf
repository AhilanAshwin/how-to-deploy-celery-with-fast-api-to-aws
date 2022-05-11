module "alb" {
  source             = "terraform-aws-modules/alb/aws"
  version            = "6.10.0"
  name               = "${local.prefix}-alb"
  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets
  #   Security group for the application load balancer
  security_groups = [module.alb-security-group.security_group_id]
  # Listeners
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
  target_groups = [
    {
      name_prefix          = "app1-"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "ip"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/ping"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      tags             = local.common_tags
    }
  ]
  tags = local.common_tags # ALB Tags
}
