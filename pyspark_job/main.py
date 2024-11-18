from pyspark.sql import SparkSession

spark = SparkSession.builder.master('local').appName('local_test').getOrCreate()

df = spark.range(1, 200)

df.show()