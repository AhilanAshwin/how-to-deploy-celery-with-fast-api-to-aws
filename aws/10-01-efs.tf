resource "aws_efs_file_system" "efs" {
  creation_token = "${local.prefix}-efs"
  tags           = local.common_tags
}

resource "aws_efs_mount_target" "efs_target" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = module.vpc.private_subnets[0]
  security_groups = [module.ecs-security-group.security_group_id]
}
