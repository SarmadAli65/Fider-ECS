variable "availability_zones" {
    description = "AZ's in the region to use"
    default = ["eu-west-1a", "eu-west-1b"]
    type = "list"
}

variable "subnet_cidrs_public" {
  description = "Subnet CIDRs for public subnets"
  default = ["10.0.0.0/24", "10.0.1.0/24"]
  type = "list"
}

variable "subnet_cidrs_private" {
    description = "Subnet CIDRs for private subnets"
    default = ["10.0.2.0/24", "10.0.3.0/24"]
    type = "list"
}