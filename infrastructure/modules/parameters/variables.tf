variable "base_url" {
    description = "the URL to access the app"
    type = string
}

variable "JWT_SECRET" {
    type = string
    sensitive = true
}

variable "database_url" {
    type = string
}