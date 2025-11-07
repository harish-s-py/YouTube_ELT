# Dockerfile
ARG AIRFLOW_VERSION=2.10.2
ARG PYTHON_VERSION=3.11

FROM python:${PYTHON_VERSION}-slim

ARG AIRFLOW_VERSION
ARG PYTHON_VERSION

ENV AIRFLOW_HOME=/opt/airflow
WORKDIR /opt/airflow

COPY requirements.txt /requirements.txt

RUN apt-get update \
 && apt-get install -y --no-install-recommends gcc curl \
 && pip install --upgrade pip \
 && CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt" \
 && echo "Using constraint: ${CONSTRAINT_URL}" \
 && pip install --no-cache-dir "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}" -r /requirements.txt \
 && apt-get purge -y --auto-remove gcc curl \
 && rm -rf /var/lib/apt/lists/*

CMD ["bash"]