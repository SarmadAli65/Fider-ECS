resource "aws_ssm_parameter" "BASE_URL" {
    name = "BASE_URL"
    type = "String"
    value = "http://${var.base_url}"
}

resource "aws_ssm_parameter" "DATABASE_URL" {
    name = "DATABASE_URL"
    type = "SecureString"
    value =  "postgres://${var.db_username}:${var.db_password}@${var.db_endpoint}/${var.db_name}"
}

resource "aws_ssm_parameter" "EMAIL_NOREPLY" {
    name = "EMAIL_NOREPLY"
    type = "String"
    value = var.email_noreply
}

resource "aws_ssm_parameter" "GO_ENV" {
    name = "GO_ENV"
    type = "String"
    value = "localhost"
}

resource "aws_ssm_parameter" "JWT_SECRET" {
    name = "JWT_SECRET"
    type = "SecureString"
    value = var.JWT_SECRET
}

resource "aws_ssm_parameter" "access_key" {
    name = "access_key"
    type = "SecureString"
    value = var.access_key
}

resource "aws_ssm_parameter" "secret_access_key" {
    name = "secret_access_key"
    type = "SecureString"
    value = var.secret_access_key
}


