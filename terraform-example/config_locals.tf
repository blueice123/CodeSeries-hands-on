# Input locals
############################
## subneting of VPC
locals {
  public_subnets_vpc = [
    {
      purpose = "sub-pub"
      zone = "${var.region}a" ## Must be put a AZs alphabet
      cidr = "10.0.0.0/24"
    },
    {
      purpose = "sub-pub"
      zone = "${var.region}c" ## Must be put a AZs alphabet
      cidr = "10.0.1.0/24"
    }
  ]
  private_subnets_vpc = [
    # {
    #   purpose = "sub-pri"
    #   zone = "${var.region}a"
    #   cidr = "10.0.200.0/24"
    # },
    # {
    #   purpose = "sub-pri"
    #   zone = "${var.region}c"
    #   cidr = "10.0.201.0/24"
    # }
  ]
}

locals {
  zone_index = { 
    "a" = 0,
    "c" = 1
  }
  nat_gateway_count = var.enable_nat ? var.single_nat ? 1 : length(local.public_subnets_vpc) : 0
}

locals {
  my_ip_addrs = join("", [local.ifconfig_co_json.ip, "/32"])
}

data "http" "my_auto_ip_addr" {
  url = try("https://ifconfig.co/json", "")
  request_headers = {
    Accept = "application/json"
  }
}
locals {
  ifconfig_co_json = jsondecode(data.http.my_auto_ip_addr.body)
}