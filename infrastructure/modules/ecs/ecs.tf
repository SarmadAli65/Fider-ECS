##### Creating the cluster the task will run on
resource "aws_ecs_cluster" "fider-cluster" {
  name = "fider-cluster"
}

#### Creating the service for the cluster
resource "aws_ecs_service" "name" {
  name = "fider-service"
  cluster = aws_ecs_cluster.fider-cluster.id
  task_definition = aws_ecs_task_definition.fider-ecs-task.arn
  launch_type = "FARGATE"

  desired_count = 2

  network_configuration {
    subnets = var.private_subnet_id
    security_groups = [ aws_security_group.ecs-sg.id ]
  }

  load_balancer {
    target_group_arn = var.alb_tg_arn
    container_name = "fider"
    container_port = 3000
  }


}

#### Configuring the task definition
resource "aws_ecs_task_definition" "fider-ecs-task" {
  family = "fider-ecs-task"
  requires_compatibilities = [ "FARGATE" ]
  network_mode = "awsvpc"
  cpu = 256
  memory = 512

  container_definitions = jsonencode( [
  
    {
      name = "fider"
      image = "019141479033.dkr.ecr.eu-west-1.amazonaws.com/ecs-fider"
      cpu = 256
      memory = 512
      essential = true
      portMappings = [
        {
          containerPort = 3000
        }
      ]
    }
  ]
  )
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture = "ARM64"
  }

  execution_role_arn = aws_iam_role.ecs-task-execution-reading.arn
}


##### Security Groups
resource "aws_security_group" "ecs-sg" {
  name = "ecs-sg"
  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "ecs-ingress-rule" {
  security_group_id = aws_security_group.ecs-sg.id
  referenced_security_group_id = var.alb_sg_id
  ip_protocol = "tcp"
  from_port = 3000
  to_port = 3000
}

resource "aws_vpc_security_group_egress_rule" "ecs-egress-rule" {
  security_group_id = aws_security_group.ecs-sg.id
  ip_protocol = "-1"
  cidr_ipv4 = "0.0.0.0/0"
}





##### IAM role for task execution and ECR reading

resource "aws_iam_role" "ecs-task-execution-reading" {
  name = "ecs-task-execution-reading"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs-reading-ssm" {
  role = aws_iam_role.ecs-task-execution-reading.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "ecs-execution-ecr" {
  role = aws_iam_role.ecs-task-execution-reading.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
