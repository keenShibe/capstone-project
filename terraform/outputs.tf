output "ecs_cluster_id" {
  value = module.ecs.ecs_cluster_id
}

output "kafka_task_definition" {
  value = module.ecs.kafka_task_definition
}

output "zookeeper_task_definition" {
  value = module.ecs.zookeeper_task_definition
}

output "selenium_task_definition" {
  value = module.ecs.selenium_task_definition
}

output "spark_task_definition" {
  value = module.ecs.spark_task_definition
}

output "dynamodb_table_name" {
  value = module.dynamodb.dynamodb_table_name
}

output "dynamodb_table_arn" {
  value = module.dynamodb.dynamodb_table_arn
}
