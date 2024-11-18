FROM python:3.8.10-slim

# Set Spark environment variables
ENV SPARK_HOME=/opt/spark \
    SPARK_VERSION=3.5.3 \
    PATH="/opt/spark/bin:/opt/mssql-tools18/bin:$PATH"

# Install Java, Spark dependencies, and utilities
RUN mkdir -p /usr/share/man/man1 && \
    apt-get update && \
    apt-get install -y openjdk-11-jdk wget curl gpg bash unixodbc-dev procps && \
    export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::") && \
    echo "JAVA_HOME=${JAVA_HOME}" >> /etc/environment && \
    wget https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
    mkdir -p ${SPARK_HOME} && \
    tar -xzf spark-${SPARK_VERSION}-bin-hadoop3.tgz -C ${SPARK_HOME} --strip-components=1 && \
    rm spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg && \
    curl https://packages.microsoft.com/config/ubuntu/24.04/prod.list | tee /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql18 mssql-tools18 && \
    rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME for the runtime environment
ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Copy the JDBC driver to the Spark jars directory
COPY mssql-jdbc-12.8.1.jre11.jar ${SPARK_HOME}/jars/

# Set up the application
WORKDIR /app
COPY main.py requirements.txt /app/

# Install Python dependencies
RUN pip install pyspark==3.5.3 && pip install -r requirements.txt

# Run the application
CMD ["python3", "/app/main.py"]
