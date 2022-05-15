resource "aws_ecs_cluster" "cluster" {
  name = "${local.prefix}-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = local.common_tags
}

resource "aws_ecs_service" "api-service" {
  name                               = "${local.prefix}-api-service"
  cluster                            = aws_ecs_cluster.cluster.id
  desired_count                      = 1
  wait_for_steady_state              = "true"
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  enable_ecs_managed_tags            = "false"
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"
  task_definition                    = aws_ecs_task_definition.api-task-definition.arn
  enable_execute_command             = "true"
  health_check_grace_period_seconds  = 10

  network_configuration {
    subnets          = module.vpc.private_subnets
    assign_public_ip = "true"
    security_groups  = [module.ecs-security-group.security_group_id]
  }

  load_balancer {
    target_group_arn = module.alb.target_group_arns[0]
    container_name   = var.app_prefix
    container_port   = var.container_port
  }

  depends_on = [
    aws_ecs_task_definition.api-task-definition,
    aws_elasticache_replication_group.redis,
    aws_s3_object.object,
    module.alb
  ]
  tags = local.common_tags
}

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

resource "aws_cloudwatch_log_group" "logs" {
  name = "${local.prefix}-logs"
  tags = local.common_tags
}

resource "aws_ecs_task_definition" "api-task-definition" {
  family                   = "${local.prefix}-api-task-definition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = data.aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name      = var.app_prefix
      image     = local.image
      essential = true
      environmentFiles = [
        {
          value = "arn:aws:s3:::celery-fastapi-dev-s3/aws.env",
          type  = "s3"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.logs.name,
          awslogs-region        = var.aws_region,
          awslogs-stream-prefix = "api"
        }
      }
      portMappings = [
        {
          containerPort = var.container_port
        }
      ]
    }
  ])
}


resource "aws_ecs_service" "worker-service" {
  name                               = "${local.prefix}-worker-service"
  cluster                            = aws_ecs_cluster.cluster.id
  desired_count                      = 1
  wait_for_steady_state              = "true"
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  enable_ecs_managed_tags            = "false"
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"
  task_definition                    = aws_ecs_task_definition.worker-task-definition.arn
  enable_execute_command             = "true"

  network_configuration {
    subnets          = module.vpc.public_subnets
    assign_public_ip = "true"
    security_groups  = [module.ecs-security-group.security_group_id]
  }

  depends_on = [
    aws_ecs_task_definition.worker-task-definition,
    aws_elasticache_replication_group.redis,
    aws_s3_object.object
  ]
  tags = local.common_tags
}


resource "aws_ecs_task_definition" "worker-task-definition" {
  family                   = "${local.prefix}-worker-task-definition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = data.aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name      = "celery-worker"
      image     = local.image
      essential = true
      environmentFiles = [
        {
          value = "arn:aws:s3:::celery-fastapi-dev-s3/aws.env",
          type  = "s3"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.logs.name,
          awslogs-region        = var.aws_region,
          awslogs-stream-prefix = "worker"
        }
      }
      command = ["celery", "--app", "app.celery_etl", "worker", "-l", "INFO"]
    }
  ])
}
