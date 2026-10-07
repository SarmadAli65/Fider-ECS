variable "vpc_id" {
    description = "the vpc ID passed from the vpc module"
    type = string
}

variable "public_subnet_ids" {
    description = "the public subnet id's"
    type = list(string)
}