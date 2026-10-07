output "vpc_id" {
    description = "This is the output of the vpc ID of the vpc"
    value = aws_vpc.ecs-fider-vpc.id
}

output "private_subnet_id" {
    description = "This is the private subnet id"
    value = aws_subnet.private[*].id
}

output "public_subnet_id" {
    description = "The private subnet id's"
    value = aws_subnet.public[*].id
}