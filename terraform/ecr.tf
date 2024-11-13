# Define an ECR repository for the Streamlit app
resource "aws_ecr_repository" "streamlit_repo" {
  name = "streamlit-app"
}

# Define an ECR repository for the Airflow app
resource "aws_ecr_repository" "airflow_repo" {
  name = "airflow-etl"
}
