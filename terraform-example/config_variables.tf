# Input Variables
############################
## Configures AWS provider
provider "aws" {
  region = var.region
  profile = "mz-syha"
}

## AWS environments
variable "key_pair" {
  description = "Define your Ec2 KeyPair name"
  type    = string
  default = "seoul_test_hsy" # 본인 키 파일이름을 입력 
}

## Slack environments
variable "SLACK_WEBHOOK_URL" {
  description = "Define your SLACK_WEBHOOK_URL"
  type    = string
  default = "https://hooks.slack.com/services/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" # 본인 키 파일이름을 입력 
}
variable "SLACK_CHANNEL" {
  description = "Define your SLACK_CHANNEL"
  type    = string
  default = "#guardduty-test" # 본인 키 파일이름을 입력 
}

variable "region" {
  description = "The region to deploy the cluster in, e.g: ap-northeast-2"
  type    = string
  default = "ap-northeast-2"
}

variable "account_id" {
  description = "The region to deploy the cluster in, e.g: ap-northeast-2"
  type    = string
  default = "239234376445"
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
