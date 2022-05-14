# resource "aws_sqs_queue" "queue" {
#   name                      = "terraform-example-queue"
#   delay_seconds             = 0
#   max_message_size          = 2048
#   message_retention_seconds = 86400
#   receive_wait_time_seconds = 0
#   tags                      = local.common_tags
# }

# resource "aws_sqs_queue_policy" "policy" {
#   queue_url = aws_sqs_queue.queue.id

#   policy = <<POLICY
# {
#   "Version": "2008-10-17",
#   "Id": "__default_policy_ID",
#   "Statement": [
#     {
#       "Sid": "__owner_statement",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "478403784717"
#       },
#       "Action": [
#         "SQS:*"
#       ],
#       "Resource": "arn:aws:sqs:ap-southeast-1:478403784717:"
#     }
#   ]
# }
# POLICY
# }

module "user_queue" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "~> 2.0"

  name = "${local.prefix}-sqs"

  tags = local.common_tags
}
