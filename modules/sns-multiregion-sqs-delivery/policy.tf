# resource "aws_sns_topic_policy" "main" {
#   arn    = aws_sns_topic.main.arn
#   policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Id": "MyTopicPolicy",
#   "Statement": [
#     {
#       "Sid": "AllowSQSPublish",
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "sns.amazonaws.com"
#       },
#       "Action": "sns:Publish",
#       "Resource": "${aws_sns_topic.main.arn}",
#       "Condition": {
#         "ArnEquals": {
#           "aws:SourceArn": "${aws_sqs_queue.my_queue.arn}"
#         }
#       }
#     }
#   ]
# }
# POLICY
# }