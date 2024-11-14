# Use a Python base image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app
RUN pip install snowplow-tracker==0.9.0

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && apt-get clean


# Install Meltano and dbt-duckdb
RUN pip install --timeout=120 --retries=5 meltano==3.5.4 dbt-duckdb==1.8.4

# Install DuckDB
RUN pip install duckdb==1.1.1

# Copy the local files into the container
COPY . .

# Expose any ports if necessary (for example, if you want to expose a web server)
# EXPOSE 8080

# Set the entrypoint to Meltano
ENTRYPOINT ["meltano"]
