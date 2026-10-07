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