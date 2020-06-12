# terraform {
#     backend "s3" {
#     region         = "ap-northeast-2"
#     bucket         = "terraform-syha" 
#     dynamodb_table = "terraform-syha"
#     key            = "training2.tfstate"
#     encrypt        = true
#   }
#   required_version = ">= 0.12"
# }