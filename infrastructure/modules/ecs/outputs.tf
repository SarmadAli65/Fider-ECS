output "ecs_sg_id" {
    description = "the id of the ecs sg"
    value = aws_security_group.ecs-sg.id
}