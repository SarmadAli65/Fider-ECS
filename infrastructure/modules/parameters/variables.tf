variable "base_url" {
    description = "the URL to access the app"
    type = string
}

variable "JWT_SECRET" {
    type = string
    sensitive = true
}

variable "db_username" {
    type = string
    sensitive = true
}

variable "db_password" {
    type = string
    sensitive = true
}

variable "db_endpoint" {
    type = string
    sensitive = false
}

variable "db_name" {
    type = string
}

variable "access_key" {
    type = string
    sensitive = true
}

variable "secret_access_key" {
    type = string
    sensitive = true
}

variable "email_noreply" {
    type = string
    sensitive = true 
}