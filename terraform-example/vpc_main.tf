# AWS Virtual Private Cloud
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
  instance_tenancy = var.instance_tenancy
  tags = {
      Name = format(
        "%s-%s-vpc",
        var.company,
        var.environment
      )
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
      Name = format(
        "%s-%s-igw",
        var.company,
        var.environment
      )
  }
}
resource "aws_route_table" "vpc_public" {
  depends_on = [aws_internet_gateway.igw] 
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = format(
        "%s-%s-vpc-rt-pub",
        var.company,
        var.environment
    )
  }
}
resource "aws_subnet" "vpc_public" {
  count = length(local.public_subnets_vpc)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = local.public_subnets_vpc[count.index].cidr
  availability_zone = local.public_subnets_vpc[count.index].zone
  tags = {
     Name = format(
         "%s-%s-%s-vpc-%s",
         var.company,
         var.environment,
         local.public_subnets_vpc[count.index].purpose,
         element(split("", local.public_subnets_vpc[count.index].zone), length(local.public_subnets_vpc[count.index].zone) - 1)
     )
   }
}
resource "aws_route_table_association" "vpc_public" {
  count = length(aws_subnet.vpc_public)
  subnet_id      = aws_subnet.vpc_public[count.index].id
  route_table_id = aws_route_table.vpc_public.id
}

resource "aws_subnet" "vpc_private" {
  count             = length(local.private_subnets_vpc)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = local.private_subnets_vpc[count.index].cidr
  availability_zone = local.private_subnets_vpc[count.index].zone
  tags = {
     Name = format(
         "%s-%s-%s-vpc-%s",
         var.company,
         var.environment,
         local.private_subnets_vpc[count.index].purpose,
         element(split("", local.private_subnets_vpc[count.index].zone), length(local.private_subnets_vpc[count.index].zone) - 1)
     )
   }
}
resource "aws_route_table" "vpc_private" {
  lifecycle {
    ignore_changes = [propagating_vgws]
  }
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = format(
        "%s-%s-vpc-rt-pri", 
        var.company,
        var.environment
    )
  }
}

resource "aws_route_table_association" "vpc_private" {
  count = length(aws_subnet.vpc_private)
  subnet_id      = aws_subnet.vpc_private[count.index].id
  route_table_id = aws_route_table.vpc_private.id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.ap-northeast-2.s3"
  tags = {
    Name = format(
        "%s-%s-ep-s3", 
        var.company,
        var.environment
    )
  }
}


resource "aws_vpc_endpoint_route_table_association" "public_rt" {
  route_table_id  = aws_route_table.vpc_public.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}
resource "aws_vpc_endpoint_route_table_association" "private_rt" {
  # count = 
  route_table_id  = aws_route_table.vpc_private.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}