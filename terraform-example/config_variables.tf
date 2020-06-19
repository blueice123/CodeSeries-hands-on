# Input Variables
############################
provider "aws" {
  region = var.region
  profile = "hands-on"  # profile 입력
}
variable "key_pair" {  
  description = "Define your Ec2 KeyPair name"
  type    = string
  default = "seoul_test_hsy" # Ec2 키 파일이름을 입력 
}
## Slack environments
variable "SLACK_WEBHOOK_URL" {
  description = "Define your SLACK_WEBHOOK_URL"
  type    = string
  default = "https://hooks.slack.com/services/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" ## Slack APP의 WEBHook 입력 
}
variable "SLACK_CHANNEL" {
  description = "Define your SLACK_CHANNEL"
  type    = string
  default = "mz-hands-on" # Slack 채널을 입력 
}
variable "SLACK_VERIFICATION_TOKEN" {
  description = "Define your SLACK_VERIFICATION_TOKEN"
  type    = string
  default = "ecvxozC3fWzGjXomvOgdBqDy" # Slack APP의 토큰 입력 hook url의 채널을 입력 
}
variable "accountId" {
  description = "Define your AWS accountId"
  type    = string
  default = "239234376445"  # AWS Account# 입력
}
# End Variables
############################

variable "region" {
  description = "The region to deploy the cluster in, e.g: ap-northeast-2"
  type    = string
  default = "ap-northeast-2"
}



variable "company" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "mz"
}
variable "environment" {
  description = "What current stage is your resource "
  type        = string
  default     = "hands-on"
}

############################
## VPC base parameters
variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_nat" {
  description = "If you don't have to create nat, you are defined false"
  type    = bool
  default = false #false | true
}
variable "single_nat" {
  description = "All public subnet NAT G/W install or not"
  type    = bool
  default = true  #false | true
}

############################
## VPC base parameters2 
variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}
variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}
variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}
variable "assign_generated_ipv6_cidr_block" {
  description = "Define whether to use ipv6"
  type        = string
  default     = "false"
}
