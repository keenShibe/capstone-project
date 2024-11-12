# Define ECS Cluster
resource "aws_ecs_cluster" "main_cluster" {
  name = "google-play-ecs-cluster"
}

# Task definition for Kafka
resource "aws_ecs_task_definition" "kafka_task" {
  family                = "kafka-task"
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "1024"
  memory                = "2048"

  container_definitions = jsonencode([{
    name      = "kafka"
    image     = "confluentinc/cp-kafka:latest"
    essential = true
    environment = [
      {
        name  = "KAFKA_BROKER_ID"
        value = "1"
      },
      {
        name  = "KAFKA_ZOOKEEPER_CONNECT"
        value = "zookeeper:2181"
      }
    ]
    portMappings = [{
      containerPort = 9092
      hostPort      = 9092
      protocol      = "tcp"
    }]
  }])
}

# Task definition for Zookeeper
resource "aws_ecs_task_definition" "zookeeper_task" {
  family                = "zookeeper-task"
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "512"
  memory                = "1024"

  container_definitions = jsonencode([{
    name      = "zookeeper"
    image     = "confluentinc/cp-zookeeper:latest"
    essential = true
    environment = [
      {
        name  = "ZOOKEEPER_CLIENT_PORT"
        value = "2181"
      }
    ]
    portMappings = [{
      containerPort = 2181
      hostPort      = 2181
      protocol      = "tcp"
    }]
  }])
}

# Task definition for Selenium
resource "aws_ecs_task_definition" "selenium_task" {
  family                = "selenium-task"
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "512"
  memory                = "1024"

  container_definitions = jsonencode([{
    name      = "selenium"
    image     = "selenium/standalone-chrome"
    essential = true
    portMappings = [{
      containerPort = 4444
      hostPort      = 4444
      protocol      = "tcp"
    }]
  }])
}

# Task definition for Spark
resource "aws_ecs_task_definition" "spark_task" {
  family                = "spark-task"
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "2048"
  memory                = "4096"

  container_definitions = jsonencode([{
    name      = "spark"
    image     = "bitnami/spark"
    essential = true
    environment = [
      {
        name  = "SPARK_MASTER"
        value = "spark://spark-master:7077"
      }
    ]
    portMappings = [{
      containerPort = 7077
      hostPort      = 7077
      protocol      = "tcp"
    }]
  }])
}
