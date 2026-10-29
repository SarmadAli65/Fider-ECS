output "iam_access_key" {
    value = aws_iam_access_key.fider_ses_user.id
    sensitive = true
}

output "iam_secret_access_key" {
  value = aws_iam_access_key.fider_ses_user.secret
  sensitive = true
}