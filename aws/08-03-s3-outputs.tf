output "s3_file_arn" {
  description = "The AWS S# arn for the env file"
  value       = aws_s3_object.object.id
}
