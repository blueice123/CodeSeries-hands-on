## Create IAM role for EC2 
resource "aws_iam_role_policy" "mz_hands-on_ssm" {
  name = "mz_hands-on_ssm-${random_id.random.hex}"
  role = aws_iam_role.mz_hands-on_ssm.id

  policy = <<-EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeAssociation",
                "ssm:GetDeployablePatchSnapshotForInstance",
                "ssm:GetDocument",
                "ssm:DescribeDocument",
                "ssm:GetManifest",
                "ssm:GetParameters",
                "ssm:ListAssociations",
                "ssm:ListInstanceAssociations",
                "ssm:PutInventory",
                "ssm:PutComplianceItems",
                "ssm:PutConfigurePackageResult",
                "ssm:UpdateAssociationStatus",
                "ssm:UpdateInstanceAssociationStatus",
                "ssm:UpdateInstanceInformation"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2messages:AcknowledgeMessage",
                "ec2messages:DeleteMessage",
                "ec2messages:FailMessage",
                "ec2messages:GetEndpoint",
                "ec2messages:GetMessages",
                "ec2messages:SendReply"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:PutMetricData"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstanceStatus"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ds:CreateComputer",
                "ds:DescribeDirectories"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketLocation",
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetEncryptionConfiguration",
                "s3:AbortMultipartUpload",
                "s3:ListMultipartUploadParts",
                "s3:ListBucket",
                "s3:ListBucketMultipartUploads"
            ],
            "Resource": "*"
        }
     ]
    }
  EOF
}
resource "aws_iam_instance_profile" "mz_hands-on_ssm" {
  name = "mz_hands-on_ssm-${random_id.random.hex}"
  role = aws_iam_role.mz_hands-on_ssm.name
}
resource "aws_iam_role" "mz_hands-on_ssm" {
  name = "mz_hands-on_ssm-${random_id.random.hex}"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow"
      }
    ]
  }
  EOF
}


## Create IAM role for CodeDeploy
resource "aws_iam_role_policy" "mz_hands-on_codedeploy" {
  name = "mz_hands-on_codedeploy-${random_id.random.hex}"
  role = aws_iam_role.mz_hands-on_codedeploy.id

  policy = <<-EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "autoscaling:CompleteLifecycleAction",
                    "autoscaling:DeleteLifecycleHook",
                    "autoscaling:DescribeAutoScalingGroups",
                    "autoscaling:DescribeLifecycleHooks",
                    "autoscaling:PutLifecycleHook",
                    "autoscaling:RecordLifecycleActionHeartbeat",
                    "autoscaling:CreateAutoScalingGroup",
                    "autoscaling:UpdateAutoScalingGroup",
                    "autoscaling:EnableMetricsCollection",
                    "autoscaling:DescribeAutoScalingGroups",
                    "autoscaling:DescribePolicies",
                    "autoscaling:DescribeScheduledActions",
                    "autoscaling:DescribeNotificationConfigurations",
                    "autoscaling:DescribeLifecycleHooks",
                    "autoscaling:SuspendProcesses",
                    "autoscaling:ResumeProcesses",
                    "autoscaling:AttachLoadBalancers",
                    "autoscaling:AttachLoadBalancerTargetGroups",
                    "autoscaling:PutScalingPolicy",
                    "autoscaling:PutScheduledUpdateGroupAction",
                    "autoscaling:PutNotificationConfiguration",
                    "autoscaling:PutLifecycleHook",
                    "autoscaling:DescribeScalingActivities",
                    "autoscaling:DeleteAutoScalingGroup",
                    "ec2:DescribeInstances",
                    "ec2:DescribeInstanceStatus",
                    "ec2:TerminateInstances",
                    "tag:GetResources",
                    "sns:Publish",
                    "cloudwatch:DescribeAlarms",
                    "cloudwatch:PutMetricAlarm",
                    "elasticloadbalancing:DescribeLoadBalancers",
                    "elasticloadbalancing:DescribeInstanceHealth",
                    "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
                    "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
                    "elasticloadbalancing:DescribeTargetGroups",
                    "elasticloadbalancing:DescribeTargetHealth",
                    "elasticloadbalancing:RegisterTargets",
                    "elasticloadbalancing:DeregisterTargets"
                ],
                "Resource": "*"
            }
        ]
    } 
  EOF
}

resource "aws_iam_role" "mz_hands-on_codedeploy" {
  name = "mz_hands-on_codedeploy-${random_id.random.hex}"
  assume_role_policy = <<-EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "",
                "Effect": "Allow",
                "Principal": {
                    "Service": [
                        "codedeploy.amazonaws.com"
                    ]
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }
  EOF
}

## Create IAM role for CodePipeline
resource "aws_iam_role_policy" "mz_hands-on_codepipeline" {
  name = "mz_hands-on_codepipeline-${random_id.random.hex}"
  role = aws_iam_role.mz_hands-on_codepipeline.id

  policy = <<-EOF
    {
        "Statement": [
            {
                "Action": [
                    "iam:PassRole"
                ],
                "Resource": "*",
                "Effect": "Allow",
                "Condition": {
                    "StringEqualsIfExists": {
                        "iam:PassedToService": [
                            "cloudformation.amazonaws.com",
                            "elasticbeanstalk.amazonaws.com",
                            "ec2.amazonaws.com",
                            "ecs-tasks.amazonaws.com"
                        ]
                    }
                }
            },
            {
                "Action": [
                    "codecommit:CancelUploadArchive",
                    "codecommit:GetBranch",
                    "codecommit:GetCommit",
                    "codecommit:GetUploadArchiveStatus",
                    "codecommit:UploadArchive"
                ],
                "Resource": "*",
                "Effect": "Allow"
            },
            {
                "Action": [
                    "codedeploy:CreateDeployment",
                    "codedeploy:GetApplication",
                    "codedeploy:GetApplicationRevision",
                    "codedeploy:GetDeployment",
                    "codedeploy:GetDeploymentConfig",
                    "codedeploy:RegisterApplicationRevision"
                ],
                "Resource": "*",
                "Effect": "Allow"
            },
            {
                "Action": [
                    "elasticbeanstalk:*",
                    "ec2:*",
                    "elasticloadbalancing:*",
                    "autoscaling:*",
                    "cloudwatch:*",
                    "s3:*",
                    "sns:*",
                    "cloudformation:*",
                    "rds:*",
                    "sqs:*",
                    "ecs:*"
                ],
                "Resource": "*",
                "Effect": "Allow"
            },
            {
                "Action": [
                    "lambda:InvokeFunction",
                    "lambda:ListFunctions"
                ],
                "Resource": "*",
                "Effect": "Allow"
            },
            {
                "Action": [
                    "opsworks:CreateDeployment",
                    "opsworks:DescribeApps",
                    "opsworks:DescribeCommands",
                    "opsworks:DescribeDeployments",
                    "opsworks:DescribeInstances",
                    "opsworks:DescribeStacks",
                    "opsworks:UpdateApp",
                    "opsworks:UpdateStack"
                ],
                "Resource": "*",
                "Effect": "Allow"
            },
            {
                "Action": [
                    "cloudformation:CreateStack",
                    "cloudformation:DeleteStack",
                    "cloudformation:DescribeStacks",
                    "cloudformation:UpdateStack",
                    "cloudformation:CreateChangeSet",
                    "cloudformation:DeleteChangeSet",
                    "cloudformation:DescribeChangeSet",
                    "cloudformation:ExecuteChangeSet",
                    "cloudformation:SetStackPolicy",
                    "cloudformation:ValidateTemplate"
                ],
                "Resource": "*",
                "Effect": "Allow"
            },
            {
                "Action": [
                    "codebuild:BatchGetBuilds",
                    "codebuild:StartBuild"
                ],
                "Resource": "*",
                "Effect": "Allow"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "devicefarm:ListProjects",
                    "devicefarm:ListDevicePools",
                    "devicefarm:GetRun",
                    "devicefarm:GetUpload",
                    "devicefarm:CreateUpload",
                    "devicefarm:ScheduleRun"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "servicecatalog:ListProvisioningArtifacts",
                    "servicecatalog:CreateProvisioningArtifact",
                    "servicecatalog:DescribeProvisioningArtifact",
                    "servicecatalog:DeleteProvisioningArtifact",
                    "servicecatalog:UpdateProduct"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "cloudformation:ValidateTemplate"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ecr:DescribeImages"
                ],
                "Resource": "*"
            }
        ],
        "Version": "2012-10-17"
    }
  EOF
}

resource "aws_iam_role" "mz_hands-on_codepipeline" {
  name = "mz_hands-on_codepipeline-${random_id.random.hex}"
  assume_role_policy = <<-EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "codepipeline.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
    }
  EOF
}



# ## Denies push, merge, PR to Commit 
# resource "aws_iam_policy" "mz_hands-on_deny_commit" {
#   name = "mz_hands-on_deny_commit-${random_id.random.hex}"
#   path        = "/"
#   description = "mz_hands-on_deny_commit"
#   policy = <<-EOF
#     {
#         "Version": "2012-10-17",
#         "Statement": [
#             {
#                 "Effect": "Deny",
#                 "Action": [
#                     "codecommit:GitPush",
#                     "codecommit:DeleteBranch",
#                     "codecommit:PutFile",
#                     "codecommit:MergeBranchesByFastForward",
#                     "codecommit:MergeBranchesBySquash",
#                     "codecommit:MergeBranchesByThreeWay",
#                     "codecommit:MergePullRequestByFastForward",
#                     "codecommit:MergePullRequestBySquash",
#                     "codecommit:MergePullRequestByThreeWay"
#                 ],
#                 "Resource": "*",
#                 "Condition": {
#                     "StringEqualsIfExists": {
#                         "codecommit:References": [
#                             "refs/heads/master", 
#                             "refs/heads/prod"
#                         ]
#                     },
#                     "Null": {
#                         "codecommit:References": false
#                     }
#                 }
#             }
#         ]
#     }
#     EOF
# }


# ## Denies push, merge, PR to Commit 
# resource "aws_iam_policy" "mz_hands-on_allow_commit" {
#   name = "mz_hands-on_allow_commit-${random_id.random.hex}"
#   path        = "/"
#   description = "mz_hands-on_allow_commit"
#   policy = <<-EOF
#     {
#         "Version": "2012-10-17",
#         "Statement": [
#             {
#                 "Effect": "Allow",
#                 "Action": [
#                     "codecommit:*"
#                 ],
#                 "Resource": "*"
#             },
#             {
#                 "Sid": "CloudWatchEventsCodeCommitRulesAccess",
#                 "Effect": "Allow",
#                 "Action": [
#                     "events:DeleteRule",
#                     "events:DescribeRule",
#                     "events:DisableRule",
#                     "events:EnableRule",
#                     "events:PutRule",
#                     "events:PutTargets",
#                     "events:RemoveTargets",
#                     "events:ListTargetsByRule"
#                 ],
#                 "Resource": "arn:aws:events:*:*:rule/codecommit*"
#             },
#             {
#                 "Sid": "SNSTopicAndSubscriptionAccess",
#                 "Effect": "Allow",
#                 "Action": [
#                     "sns:CreateTopic",
#                     "sns:DeleteTopic",
#                     "sns:Subscribe",
#                     "sns:Unsubscribe",
#                     "sns:SetTopicAttributes"
#                 ],
#                 "Resource": "arn:aws:sns:*:*:codecommit*"
#             },
#             {
#                 "Sid": "SNSTopicAndSubscriptionReadAccess",
#                 "Effect": "Allow",
#                 "Action": [
#                     "sns:ListTopics",
#                     "sns:ListSubscriptionsByTopic",
#                     "sns:GetTopicAttributes"
#                 ],
#                 "Resource": "*"
#             },
#             {
#                 "Sid": "LambdaReadOnlyListAccess",
#                 "Effect": "Allow",
#                 "Action": [
#                     "lambda:ListFunctions"
#                 ],
#                 "Resource": "*"
#             },
#             {
#                 "Sid": "IAMReadOnlyListAccess",
#                 "Effect": "Allow",
#                 "Action": [
#                     "iam:ListUsers"
#                 ],
#                 "Resource": "*"
#             },
#             {
#                 "Sid": "IAMReadOnlyConsoleAccess",
#                 "Effect": "Allow",
#                 "Action": [
#                     "iam:ListAccessKeys",
#                     "iam:ListSSHPublicKeys",
#                     "iam:ListServiceSpecificCredentials"
#                 ],
#                 "Resource": "arn:aws:iam::*:user/$${aws:username}"
#             },
#             {
#                 "Sid": "IAMUserSSHKeys",
#                 "Effect": "Allow",
#                 "Action": [
#                     "iam:DeleteSSHPublicKey",
#                     "iam:GetSSHPublicKey",
#                     "iam:ListSSHPublicKeys",
#                     "iam:UpdateSSHPublicKey",
#                     "iam:UploadSSHPublicKey"
#                 ],
#                 "Resource": "arn:aws:iam::*:user/$${aws:username}"
#             },
#             {
#                 "Sid": "IAMSelfManageServiceSpecificCredentials",
#                 "Effect": "Allow",
#                 "Action": [
#                     "iam:CreateServiceSpecificCredential",
#                     "iam:UpdateServiceSpecificCredential",
#                     "iam:DeleteServiceSpecificCredential",
#                     "iam:ResetServiceSpecificCredential"
#                 ],
#                 "Resource": "arn:aws:iam::*:user/$${aws:username}"
#             },
#             {
#                 "Sid": "CodeStarNotificationsReadWriteAccess",
#                 "Effect": "Allow",
#                 "Action": [
#                     "codestar-notifications:CreateNotificationRule",
#                     "codestar-notifications:DescribeNotificationRule",
#                     "codestar-notifications:UpdateNotificationRule",
#                     "codestar-notifications:DeleteNotificationRule",
#                     "codestar-notifications:Subscribe",
#                     "codestar-notifications:Unsubscribe"
#                 ],
#                 "Resource": "*",
#                 "Condition": {
#                     "StringLike": {
#                         "codestar-notifications:NotificationsForResource": "arn:aws:codecommit:*"
#                     }
#                 }
#             },
#             {
#                 "Sid": "CodeStarNotificationsListAccess",
#                 "Effect": "Allow",
#                 "Action": [
#                     "codestar-notifications:ListNotificationRules",
#                     "codestar-notifications:ListTargets",
#                     "codestar-notifications:ListTagsforResource",
#                     "codestar-notifications:ListEventTypes"
#                 ],
#                 "Resource": "*"
#             },
#             {
#                 "Sid": "CodeStarNotificationsSNSTopicCreateAccess",
#                 "Effect": "Allow",
#                 "Action": [
#                     "sns:CreateTopic",
#                     "sns:SetTopicAttributes"
#                 ],
#                 "Resource": "arn:aws:sns:*:*:codestar-notifications*"
#             },
#             {
#                 "Sid": "AmazonCodeGuruReviewerFullAccess",
#                 "Effect": "Allow",
#                 "Action": [
#                     "codeguru-reviewer:AssociateRepository",
#                     "codeguru-reviewer:DescribeRepositoryAssociation",
#                     "codeguru-reviewer:ListRepositoryAssociations",
#                     "codeguru-reviewer:DisassociateRepository"
#                 ],
#                 "Resource": "*"
#             },
#             {
#                 "Sid": "AmazonCodeGuruReviewerSLRCreation",
#                 "Action": "iam:CreateServiceLinkedRole",
#                 "Effect": "Allow",
#                 "Resource": "arn:aws:iam::*:role/aws-service-role/codeguru-reviewer.amazonaws.com/AWSServiceRoleForAmazonCodeGuruReviewer",
#                 "Condition": {
#                     "StringLike": {
#                         "iam:AWSServiceName": "codeguru-reviewer.amazonaws.com"
#                     }
#                 }
#             },
#             {
#                 "Sid": "CloudWatchEventsManagedRules",
#                 "Effect": "Allow",
#                 "Action": [
#                     "events:PutRule",
#                     "events:PutTargets",
#                     "events:DeleteRule",
#                     "events:RemoveTargets"
#                 ],
#                 "Resource": "*",
#                 "Condition": {
#                     "StringEquals": {
#                         "events:ManagedBy": "codeguru-reviewer.amazonaws.com"
#                     }
#                 }
#             },
#             {
#                 "Sid": "CodeStarNotificationsChatbotAccess",
#                 "Effect": "Allow",
#                 "Action": [
#                     "chatbot:DescribeSlackChannelConfigurations"
#                 ],
#                 "Resource": "*"
#             }
#         ]
#     }
#   EOF
# }