resource "aws_sqs_queue_policy" "main" {
  queue_url = aws_sqs_queue.main.id
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "sqs:SendMessage"
      ],
      "Resource": [
        "${aws_sqs_queue.main.arn}"
      ],
      "Condition": {
        "ArnLike": {
          "aws:SourceArn": [
            "arn:aws:sns:us-east-1:${data.aws_caller_identity.current.account_id}:*",
            "arn:aws:sns:sa-east-1:${data.aws_caller_identity.current.account_id}:*",
            "arn:aws:sns:sa-east-1:${data.aws_caller_identity.current.account_id}:${var.sns_topic_name}",
            "arn:aws:sns:us-east-1:${data.aws_caller_identity.current.account_id}:${var.sns_topic_name}"
          ]
        }
      }
    }
  

  ]
}
EOF
}