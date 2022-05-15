module "user_queue" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "~> 2.0"

  name = "${local.prefix}-sqs"

  tags = local.common_tags
}
