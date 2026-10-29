variable "db_username" {
  type = string
  sensitive = true
}

variable "db_password" {
    type = string
    sensitive = true
}

variable "JWT_SECRET" {
    type = string
    sensitive = true
}

variable "verified_email" {
    type = string
    sensitive = true
}

variable "email_noreply" {
    type = string
    sensitive = true
}