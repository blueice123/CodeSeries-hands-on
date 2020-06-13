resource "aws_s3_bucket" "s3_for_artifact" {
  bucket = "${var.company}-${var.environment}-artifact-${random_id.random.hex}"
  region = var.region
  acl    = "private"
  force_destroy = true
  tags = {
    Name = format(
      "%s-%s-artifact",
      var.company,
      var.environment
     )
   }
}