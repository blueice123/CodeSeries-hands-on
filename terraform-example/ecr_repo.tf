resource "aws_ecr_repository" "mz-hands-on-ecr" {
  name                 = "mz-hands-on-ecr-${random_id.random.hex}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false # true
  }
}