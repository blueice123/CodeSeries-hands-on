## Create IAM Users
resource "aws_iam_user" "iam_developer" {
  name = "mz_hands-on_developer-${random_id.random.hex}"
  path = "/"
}
resource "aws_iam_user" "iam_admin" {
  name = "mz_hands-on_admin-${random_id.random.hex}"
  path = "/"
}
# resource "aws_iam_user_login_profile" "iam_developer" {
#   user    = aws_iam_user.iam_developer.name
#   pgp_key = "keybase:megazone-hands-on"
#   password_reset_required = false #true
# }
# resource "aws_iam_user_login_profile" "iam_admin" {
#   user    = aws_iam_user.iam_admin.name
#   pgp_key = "keybase:megazone-hands-on"
#   password_reset_required = false #true
# }
# output "iam_developer" {
#   value = aws_iam_user_login_profile.iam_developer.encrypted_password
# }
# output "iam_admin" {
#   value = aws_iam_user_login_profile.iam_admin.encrypted_password
# }

## Attaching role to IAM Users
resource "aws_iam_user_policy_attachment" "iam_developer1" {
  user       = aws_iam_user.iam_developer.name
  policy_arn = aws_iam_policy.iam_developer.arn
}
resource "aws_iam_user_policy_attachment" "iam_developer2" {
  user       = aws_iam_user.iam_developer.name
  policy_arn = aws_iam_policy.iam_admin.arn
}
resource "aws_iam_user_policy_attachment" "iam_developer3" {
  user       = aws_iam_user.iam_developer.name
  policy_arn = aws_iam_policy.iam_selfchange.arn
}
resource "aws_iam_user_policy_attachment" "iam_admin" {
  user       = aws_iam_user.iam_admin.name
  policy_arn = aws_iam_policy.iam_admin.arn
}
resource "aws_iam_user_policy_attachment" "iam_admin2" {
  user       = aws_iam_user.iam_admin.name
  policy_arn = aws_iam_policy.iam_selfchange.arn
}

## Create IAM policies
resource "aws_iam_policy" "iam_developer" {
  name        = "mz_hands-on_deny-${random_id.random.hex}"
  description = "mz_hands-on_deny-${random_id.random.hex}"
  policy      = <<-EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Deny",
                "Action": [
                    "codecommit:GitPush",
                    "codecommit:DeleteBranch",
                    "codecommit:PutFile",
                    "codecommit:MergeBranchesByFastForward",
                    "codecommit:MergeBranchesBySquash",
                    "codecommit:MergeBranchesByThreeWay",
                    "codecommit:MergePullRequestByFastForward",
                    "codecommit:MergePullRequestBySquash",
                    "codecommit:MergePullRequestByThreeWay"
                ],
                "Resource": "*",
                "Condition": {
                    "StringEqualsIfExists": {
                        "codecommit:References": [
                            "refs/heads/master",
                            "refs/heads/production"
                        ]
                    },
                    "Null": {
                        "codecommit:References": false
                    }
                }
            }
        ]
    }
  EOF
}

resource "aws_iam_policy" "iam_admin" {
  name        = "mz_hands-on_allow-${random_id.random.hex}"
  description = "mz_hands-on_allow-${random_id.random.hex}"
  policy      = <<-EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "codecommit:AssociateApprovalRuleTemplateWithRepository",
                    "codecommit:BatchAssociateApprovalRuleTemplateWithRepositories",
                    "codecommit:BatchDisassociateApprovalRuleTemplateFromRepositories",
                    "codecommit:BatchGet*",
                    "codecommit:BatchDescribe*",
                    "codecommit:Create*",
                    "codecommit:DeleteBranch",
                    "codecommit:DeleteFile",
                    "codecommit:Describe*",
                    "codecommit:DisassociateApprovalRuleTemplateFromRepository",
                    "codecommit:EvaluatePullRequestApprovalRules",
                    "codecommit:Get*",
                    "codecommit:List*",
                    "codecommit:Merge*",
                    "codecommit:OverridePullRequestApprovalRules",
                    "codecommit:Put*",
                    "codecommit:Post*",
                    "codecommit:TagResource",
                    "codecommit:Test*",
                    "codecommit:UntagResource",
                    "codecommit:Update*",
                    "codecommit:GitPull",
                    "codecommit:GitPush"
                ],
                "Resource": "*"
            },
            {
                "Sid": "IAMReadOnlyListAccess",
                "Effect": "Allow",
                "Action": [
                    "iam:ListUsers"
                ],
                "Resource": "*"
            },
            {
                "Sid": "IAMReadOnlyConsoleAccess",
                "Effect": "Allow",
                "Action": [
                    "iam:ListAccessKeys",
                    "iam:ListSSHPublicKeys",
                    "iam:ListServiceSpecificCredentials"
                ],
                "Resource": "arn:aws:iam::*:user/$${aws:username}"
            },
            {
                "Sid": "IAMUserSSHKeys",
                "Effect": "Allow",
                "Action": [
                    "iam:DeleteSSHPublicKey",
                    "iam:GetSSHPublicKey",
                    "iam:ListSSHPublicKeys",
                    "iam:UpdateSSHPublicKey",
                    "iam:UploadSSHPublicKey"
                ],
                "Resource": "arn:aws:iam::*:user/$${aws:username}"
            },
            {
                "Sid": "IAMSelfManageServiceSpecificCredentials",
                "Effect": "Allow",
                "Action": [
                    "iam:CreateServiceSpecificCredential",
                    "iam:UpdateServiceSpecificCredential",
                    "iam:DeleteServiceSpecificCredential",
                    "iam:ResetServiceSpecificCredential"
                ],
                "Resource": "arn:aws:iam::*:user/$${aws:username}"
            },
            {
                "Sid": "CodeStarNotificationsChatbotAccess",
                "Effect": "Allow",
                "Action": [
                    "chatbot:DescribeSlackChannelConfigurations"
                ],
                "Resource": "*"
            }
        ]
    }
  EOF
}

resource "aws_iam_policy" "iam_selfchange" {
  name        = "mz_hands-on_self-${random_id.random.hex}"
  description = "mz_hands-on_self-${random_id.random.hex}"
  policy      = <<-EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "ViewAccountPasswordRequirements",
                "Effect": "Allow",
                "Action": "iam:GetAccountPasswordPolicy",
                "Resource": "*"
            },
            {
                "Sid": "ChangeOwnAccount",
                "Effect": "Allow",
                "Action": [
                    "iam:GetUser",
                    "iam:ChangePassword",
                    "iam:ListUserPolicies",
                    "iam:CreateVirtualMFADevice",
                    "iam:DeactivateMFADevice",
                    "iam:EnableMFADevice",
                    "iam:ListMFADevices",
                    "iam:ResyncMFADevice",
                    "iam:GetLoginProfile",
                    "iam:UpdateLoginProfile",
                    "iam:ListAttachedUserPolicies",
                    "iam:ListGroupsForUser"
                ],
                "Resource": "arn:aws:iam::*:user/$${aws:username}"
            }
        ]
    }
  EOF
}



