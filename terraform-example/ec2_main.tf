resource "aws_instance" "front_production" {
  ami = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = var.key_pair
  vpc_security_group_ids      = [aws_security_group.security_group.id]
  subnet_id = aws_subnet.vpc_public[0].id
  private_ip = "10.0.0.10"
  iam_instance_profile = aws_iam_instance_profile.mz_hands-on_ssm.name
  credit_specification {
    cpu_credits = "standard"
  }
  user_data = data.template_file.ec2_init.rendered
  tags = {
    Name = format(
      "%s-%s-production",
      var.company,
      var.environment
     ) 
     Environment = "front-production" 
   }
  volume_tags = {
    Name = format(
      "%s-%s-production",
      var.company,
      var.environment
     )
     Environment = "front-production" 
  }
}
resource "aws_eip" "eip_for_front_production" {
  instance = aws_instance.front_production.id
  vpc      = true
  tags = {
    Name = "%s-%s-production-eip"
   }
}

resource "aws_instance" "front_develop" {
  ami = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = var.key_pair
  vpc_security_group_ids      = [aws_security_group.security_group.id]
  subnet_id = aws_subnet.vpc_public[0].id
  private_ip = "10.0.0.20"
  iam_instance_profile = aws_iam_instance_profile.mz_hands-on_ssm.name
  credit_specification {
    cpu_credits = "standard"
  }
  user_data = data.template_file.ec2_init.rendered
  tags = {
    Name = format(
      "%s-%s-develop",
      var.company,
      var.environment
     ) 
     Environment = "front-develop" 
   }
  volume_tags = {
    Name = format(
      "%s-%s-develop",
      var.company,
      var.environment
     )
     Environment = "front-develop" 
  }
}
resource "aws_eip" "eip_for_front_develop" {
  instance = aws_instance.front_develop.id
  vpc      = true
  tags = {
    Name = "%s-%s-develop-eip"
   }
}

resource "aws_security_group" "security_group" {
  ingress {
    description = "For accessing via RDP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [local.my_ip_addrs]
  }
  ingress {
    description = "For accessing via SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.my_ip_addrs]
  }
  ingress {
    description = "For WebServices"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = aws_vpc.vpc.id
  name = format(
      "%s-%s-sg",
      var.company,
      var.environment
     )
  description = format(
      "%s-%s-sg",
      var.company,
      var.environment
     )
  tags = {
    Name = format(
      "%s-%s-sg",
      var.company,
      var.environment
     )
  }
}

