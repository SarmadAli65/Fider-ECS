output "fider-alb-sg" {
    description = "the sg id of the alb"
    value = aws_security_group.alb_sg.id
}

output "fider-alb-tg" {
    description = "the arn of the alb target group"
    value = aws_lb_target_group.fider-target-group.arn
}

output "fider-alb-dns_name" {
    description = "the alb url"
    value = aws_lb.fider-alb.dns_name
}

