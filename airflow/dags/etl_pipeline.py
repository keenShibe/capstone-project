from airflow import DAG
from airflow.operators.ecs_operator import ECSOperator
from airflow.utils.dates import days_ago
from datetime import timedelta

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'google_play_etl',
    default_args=default_args,
    description='ETL for Google Play Store Reviews',
    schedule_interval=timedelta(hours=1),
    start_date=days_ago(1),
    catchup=False,
)

run_selenium = ECSOperator(
    task_id='run_selenium_scraper',
    dag=dag,
    cluster="google-play-ecs-cluster",
    task_definition="selenium-task:1",
    launch_type="FARGATE",
    overrides={
        "containerOverrides": [
            {
                "name": "selenium",
                "environment": [
                    {"name": "APP_URL", "value": "https://play.google.com/store/apps/details?id=com.example"}
                ]
            }
        ]
    },
    network_configuration={
        'awsvpcConfiguration': {
            'subnets': ["subnet-XXXXXXXX"],
            'securityGroups': ["sg-XXXXXXXX"],
            'assignPublicIp': 'ENABLED'
        }
    }
)

process_reviews = ECSOperator(
    task_id='process_reviews_with_spark',
    dag=dag,
    cluster="google-play-ecs-cluster",
    task_definition="spark-task:1",
    launch_type="FARGATE",
    network_configuration={
        'awsvpcConfiguration': {
            'subnets': ["subnet-XXXXXXXX"],
            'securityGroups': ["sg-XXXXXXXX"],
            'assignPublicIp': 'ENABLED'
        }
    }
)

run_selenium >> process_reviews
