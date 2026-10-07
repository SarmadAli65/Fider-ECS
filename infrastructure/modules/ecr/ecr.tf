resource "aws_ecr_repository" "fider-ecs" {
    name = "fider-ecs"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
      scan_on_push = true
    }
}