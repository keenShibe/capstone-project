# Start with an official Apache Airflow base image
FROM apache/airflow:2.6.3

# Install any additional Python dependencies needed for the DAGs or custom operators
# (e.g., boto3 for AWS interactions, pandas for data processing)
RUN pip install --no-cache-dir boto3 pandas

# Copy the DAGs to the Airflow DAGs directory
COPY dags/ /opt/airflow/dags/

# Copy any additional configuration files (e.g., airflow.cfg) if needed
# Uncomment and use if you have a custom airflow.cfg
# COPY airflow.cfg /opt/airflow/airflow.cfg

# Set Airflow environment variables
ENV AIRFLOW__CORE__EXECUTOR=LocalExecutor
ENV AIRFLOW__CORE__LOAD_EXAMPLES=False

# Expose the port for the Airflow web server (default is 8080)
EXPOSE 8080

# Set the default command to start the Airflow web server and scheduler
CMD ["bash", "-c", "airflow db init && airflow scheduler & airflow webserver"]
