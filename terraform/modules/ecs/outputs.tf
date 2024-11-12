output "ecs_cluster_id" {
  value = aws_ecs_cluster.main_cluster.id
}

output "kafka_task_definition" {
  value = aws_ecs_task_definition.kafka_task.arn
}

output "zookeeper_task_definition" {
  value = aws_ecs_task_definition.zookeeper_task.arn
}

output "selenium_task_definition" {
  value = aws_ecs_task_definition.selenium_task.arn
}

output "spark_task_definition" {
  value = aws_ecs_task_definition.spark_task.arn
}
