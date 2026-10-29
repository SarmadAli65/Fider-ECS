variable "private_subnet_id" {
    description = "the subnet id's for the tasks to be hosted in"
    type = list(string)
}

variable "vpc_id" {
    description = "the vpc id"
    type = string
}

variable "alb_sg_id" {
    description = "the alb sg id"
    type = string
}

variable "alb_tg_arn" {
    description = "the alb target group arn"
    type = string
}

variable "BASE_URL" {
    type = string
}

variable "DATABASE_URL" {
    type = string
}

variable "EMAIL_NOREPLY" {
    type = string
}

variable "GO_ENV" {
    type = string
}

variable "JWT_SECRET" {
    type = string
}

variable "ACCESS_KEY" {
    type = string
}

variable "SECRET_ACCESS_KEY" {
    type = string
}