resource "aws_codecommit_repository" "commit_ec2" {
  repository_name = "mz-hands-on-ec2-${random_id.random.hex}"
  description     = "This is the hands-on APP Repository"
}

resource "aws_codecommit_repository" "commit_fargate" {
  repository_name = "mz-hands-on-fargate-${random_id.random.hex}"
  description     = "This is the hands-on APP Repository"
}