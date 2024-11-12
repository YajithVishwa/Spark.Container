# Dockerfile
FROM spark:3.5.3-scala2.12-java11-ubuntu

USER root

# Install necessary tools
RUN set -ex; \
    apt-get update; \
    apt-get install -y python3 python3-pip curl gnupg; \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /mount

# Add the signature to trust the Microsoft repo
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg;

# Add repo to apt sources
RUN curl https://packages.microsoft.com/config/ubuntu/24.04/prod.list | tee /etc/apt/sources.list.d/mssql-release.list

# Install the driver
RUN apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql18 && \
    ACCEPT_EULA=Y apt-get install -y mssql-tools18 && \
    echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc && \
    apt-get install -y unixodbc-dev && \
    rm -rf /var/lib/apt/lists/*

ENV SPARK_HOME=/opt/spark
ENV PATH="$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin"
RUN chown -R spark:spark $SPARK_HOME

COPY mssql-jdbc-12.8.1.jre11.jar /opt/spark/jars/

# Expose ports for Spark master and worker
EXPOSE 7077 8080

COPY requirements.txt /requirements.txt

RUN pip install --no-cache-dir -r /requirements.txt

# Start Spark master
#CMD ["/opt/spark/bin/spark-class", "org.apache.spark.deploy.master.Master"]
