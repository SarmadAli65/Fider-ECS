resource "aws_ssm_parameter" "BASE_URL" {
    name = "BASE_URL"
    type = "String"
    value = var.base_url
}

resource "aws_ssm_parameter" "DATABASE_URL" {
    name = "DATABASE_URL"
    type = "String"
    value = var.database_url  
}

resource "aws_ssm_parameter" "EMAIL_NOREPLY" {
    name = "EMAIL_NOREPLY"
    type = "String"
    value = "noreply@yourdomain.com"
}

resource "aws_ssm_parameter" "GO_ENV" {
    name = "GO_ENV"
    type = "String"
    value = "localhost"
}

resource "aws_ssm_parameter" "JWT_SECRET" {
    name = "JWT_SECRET"
    type = "String"
    value = var.JWT_SECRET
}


