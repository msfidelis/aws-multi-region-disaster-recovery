output "arn" {
  value = aws_sns_topic.main.arn
}

output "name" {
  value = aws_sns_topic.main.display_name
}