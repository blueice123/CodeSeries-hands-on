data "aws_ami" "amazon-linux-2" {
 most_recent = true
 owners = ["137112412989"]
 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }
 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

data "template_file" "ec2_init" {
  template = file("./script/ec2_init.sh")
}
resource "random_id" "random" {
    byte_length = 4
}

data "aws_ami" "ms_win_2016" {
 most_recent = true
 owners = ["801119661308"]
 filter {
   name   = "name"
   values = ["Windows_Server-2016-English-Full-Base-*"]
 }
}