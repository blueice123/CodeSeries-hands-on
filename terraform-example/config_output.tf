# # output context 
# ############################
output "s3_bucket" {
    value = aws_s3_bucket.s3_for_artifact.bucket
}
output "eip_for_front_production" {
    value = aws_eip.eip_for_front_production.public_ip
}
output "eip_for_front_develop" {
    value = aws_eip.eip_for_front_develop.public_ip
}
output "CodeCommit_ec2" {
    value = aws_codecommit_repository.commit_ec2.clone_url_http
}
output "CodeCommit_fargate" {
    value = aws_codecommit_repository.commit_fargate.clone_url_http
}