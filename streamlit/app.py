import streamlit as st
import boto3
import json

# Set up ECS client
ecs_client = boto3.client('ecs', region_name='us-east-1')

# User input for Google Play Store URL
st.title("Google Play Store Review Scraper")
app_url = st.text_input("Enter Google Play Store App URL:")

if st.button("Start Scraping"):
    # Trigger ECS task to run Selenium scraper
    if app_url:
        response = ecs_client.run_task(
            cluster="google-play-ecs-cluster",
            taskDefinition="selenium-task:1",
            launchType="FARGATE",
            networkConfiguration={
                'awsvpcConfiguration': {
                    'subnets': ["subnet-XXXXXXXX"],
                    'securityGroups': ["sg-XXXXXXXX"],
                    'assignPublicIp': 'ENABLED'
                }
            },
            overrides={
                "containerOverrides": [
                    {
                        "name": "selenium",
                        "environment": [
                            {"name": "APP_URL", "value": app_url}
                        ]
                    }
                ]
            }
        )
        st.success("Scraping task started successfully!")
    else:
        st.error("Please enter a valid Google Play Store URL.")
