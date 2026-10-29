output "BASE_URL" {
    value = aws_ssm_parameter.BASE_URL.arn
}

output "DATABASE_URL" {
  value = aws_ssm_parameter.DATABASE_URL.arn
}

output "EMAIL_NOREPLY" {
  value = aws_ssm_parameter.EMAIL_NOREPLY.arn
}

output "GO_ENV" {
    value = aws_ssm_parameter.GO_ENV.arn
}

output "JWT_SECRET" {
    value = aws_ssm_parameter.JWT_SECRET.arn
}

output "ACCESS_KEY" {
  value = aws_ssm_parameter.access_key.arn
  sensitive = true
}

output "SECRET_ACCESS_KEY" {
  value = aws_ssm_parameter.secret_access_key.arn
  sensitive = true
}