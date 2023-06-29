
# resource "aws_ecr_replication_configuration" "main" {
#   replication_configuration {
#     rule {

#       destination {
#         region      = "sa-east-1"
#         registry_id = data.aws_caller_identity.current.account_id
#       }

#       destination {
#         region      = "us-east-1"
#         registry_id = data.aws_caller_identity.current.account_id
#       }

#       repository_filter {
#         filter      = var.project_name
#         filter_type = "PREFIX_MATCH"
#       }
#     }
#   }
# }