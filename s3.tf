# module "bucket_sa_east_1" {
#   source = "./modules/s3_bucket"

#   providers = {
#     aws = aws.primary
#   }

#   bucket_name_prefix = "processed-sale"
# }


# module "bucket_us_east_1" {
#   source = "./modules/s3_bucket"

#   providers = {
#     aws = aws.disaster-recovery

#   }

#   bucket_name_prefix = "processed-sale"
# }


# // Replication IAM

# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["s3.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

# resource "aws_iam_role" "replication" {
#   provider           = aws.primary
#   name               = format("sales-s3-replication")
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# data "aws_iam_policy_document" "replication" {
#   statement {
#     effect = "Allow"

#     actions = [
#       "s3:GetReplicationConfiguration",
#       "s3:ListBucket",
#     ]

#     resources = [
#       module.bucket_sa_east_1.arn,
#       module.bucket_us_east_1.arn,
#     ]
#   }

#   statement {
#     effect = "Allow"

#     actions = [
#       "s3:GetObjectVersionForReplication",
#       "s3:GetObjectVersionAcl",
#       "s3:GetObjectVersionTagging",
#       "s3:ReplicateObject",
#       "s3:ReplicateDelete",
#       "s3:ReplicateTags",
#     ]

#     resources = [
#       "${module.bucket_sa_east_1.arn}/*",
#       "${module.bucket_us_east_1.arn}/*"
#     ]
#   }

# }

# resource "aws_iam_policy" "replication" {
#   provider = aws.primary
#   name     = format("sales-s3-replication")
#   policy   = data.aws_iam_policy_document.replication.json
# }

# resource "aws_iam_role_policy_attachment" "replication" {
#   provider   = aws.primary
#   role       = aws_iam_role.replication.name
#   policy_arn = aws_iam_policy.replication.arn
# }

# resource "aws_s3_bucket_replication_configuration" "primary" {

#   provider = aws.primary

#   role   = aws_iam_role.replication.arn
#   bucket = module.bucket_sa_east_1.id

#   rule {
#     id = "sales"

#     filter {
#       prefix = "sales"
#     }

#     status = "Enabled"

#     destination {
#       bucket        = module.bucket_us_east_1.arn
#       storage_class = "STANDARD"
#     }
#   }
# }


# resource "aws_s3_bucket_replication_configuration" "disaster_recovery" {

#   provider = aws.disaster-recovery

#   role   = aws_iam_role.replication.arn
#   bucket = module.bucket_us_east_1.id

#   rule {
#     id = "sales"

#     filter {
#       prefix = "sales"
#     }

#     status = "Enabled"

#     destination {
#       bucket        = module.bucket_sa_east_1.arn
#       storage_class = "STANDARD"
#     }
#   }
# }
