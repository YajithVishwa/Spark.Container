#!/bin/bash

#install requirements
pip install --no-cache-dir -r /requirements.txt

# Start the Spark master in the background
/opt/spark/bin/spark-class org.apache.spark.deploy.master.Master -h localhost &

# Start the Spark worker in the background, connecting to the master
/opt/spark/bin/spark-class org.apache.spark.deploy.worker.Worker spark://localhost:7077 &

# Keep the container running
tail -f /dev/null
