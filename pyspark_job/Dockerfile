FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    SPARK_HOME=/opt/spark \
    SPARK_VERSION=3.5.3 \
    PATH="/opt/spark/bin:/opt/mssql-tools18/bin:$PATH"

RUN mkdir -p /usr/share/man/man1 && \
    apt-get update && \
    apt-get install -y openjdk-11-jdk wget curl gpg bash unixodbc-dev procps python3 python3-pip  && \
    export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::") && \
    echo "JAVA_HOME=${JAVA_HOME}" >> /etc/environment && \
    wget https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
    mkdir -p ${SPARK_HOME} && \
    tar -xzf spark-${SPARK_VERSION}-bin-hadoop3.tgz -C ${SPARK_HOME} --strip-components=1 && \
    rm spark-${SPARK_VERSION}-bin-hadoop3.tgz && \
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/microsoft-prod.gpg] https://packages.microsoft.com/ubuntu/22.04/prod jammy main" > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql18 mssql-tools18 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN python --version && pip3 --version

ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
ENV PATH="${JAVA_HOME}/bin:/usr/bin/python3:/usr/bin/pip:${PATH}"

COPY mssql-jdbc-12.8.1.jre11.jar ${SPARK_HOME}/jars/

RUN pip install pyspark==3.5.3

# Above code is build and kept ready in https://hub.docker.com/r/yajith2001/pyspark-job
WORKDIR /app

COPY main.py requirements.txt /app/

RUN pip install -r requirements.txt

CMD ["python", "/app/main.py"]
