##### ALB Secuirty Group
resource "aws_security_group" "alb_sg" {
    name = "alb_sg"
    description = "the sg for the alb"
    vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
    security_group_id = aws_security_group.alb_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 80
    ip_protocol = "tcp"
    to_port = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
    security_group_id = aws_security_group.alb_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}


#### Creating ALB
resource "aws_lb" "fider-alb" {
    name = "fider-alb"
    load_balancer_type = "application"
    security_groups = [aws_security_group.alb_sg.id]
    subnets = var.public_subnet_ids
    

}

resource "aws_lb_target_group" "fider-target-group" {
    name = "fider-target-group"
    port = 3000
    protocol = "HTTP"
    target_type = "ip"
    vpc_id = var.vpc_id
}

resource "aws_lb_listener" "fider-listener" {
    load_balancer_arn = aws_lb.fider-alb.arn
    port = "80"
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.fider-target-group.arn
    }
}