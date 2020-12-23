# aws-glue-monorepo-style

An example of AWS Glue Jobs and workflow deployment with terraform in monorepo style.

To learn more about decisions behind this structure chek out the supporting articles:
https://dev.to/1oglop1/aws-glue-first-experience-part-1-how-to-run-your-code-3pe3

![architecture of this solution](arch_diagram.png)
(for simplicity this solution uses just 1 bucket and does not deploy database)

## Deployment:

Requirements:

* AWS Account
* S3 bucket to store terraform state.
* Rename `.evn.example` to `.env` and set the values
* export environment variables from `.env` using command: `set -o allexport; source .env; set +o allexport`
* `docker-compose up -d`
* `docker exec -it glue /bin/bash`

Now we are going to work inside the docker container

* `make tf-init`
* `make tf-plan`
* `make tf-apply`
* `make jobs-deploy`

That's it!
If everything went well you can now go to AWS Glue Console and explore jobs and workflows.

Or start workflow from CLI `aws glue start-workflow-run --name etl-workflow--simple`

Once you are finished with observations remove everything with  `make tf-destroy`.

## Development

With the [release of Glue 2.0 AWS](https://aws.amazon.com/blogs/big-data/developing-aws-glue-etl-jobs-locally-using-a-container/)
released official Glue Docker Image you can use it for local development of glue jobs.

example:

* `docker exec -it glue /bin/bash` to connect into our container
* `cd /project/glue/data_sources/ds1/raw_to_refined`
* `pip install -r requirements.txt`  
* Run the fist job `python raw_to_refined.py --APP_SETTINGS_ENVIRONMENT=dev --LOG_LEVEL=DEBUG --S3_BUCKET=${TF_VAR_glue_bucket_name}`  
* `cd /project/glue/data_sources/ds1/refined_to_curated`
* Next step requires results from previous stage `raw_to_refined`
* Run the second job `python refined_to_curated.py --APP_SETTINGS_ENVIRONMENT=dev --LOG_LEVEL=DEBUG --S3_BUCKET=${TF_VAR_glue_bucket_name}`

If everything went well you should see output like this:

```
2020-12-23 14:28:43,278 DEBUG    glue_shared.spark_helpers - DF: +--------------------+-----------+-----------+--------+-------+---+------+-----+-----+------+------+--------+-----+------+-----+---------+
|                name|        mfr|       type|calories|protein|fat|sodium|fiber|carbo|sugars|potass|vitamins|shelf|weight| cups|   rating|
+--------------------+-----------+-----------+--------+-------+---+------+-----+-----+------+------+--------+-----+------+-----+---------+
|              String|Categorical|Categorical|     Int|    Int|Int|   Int|Float|Float|   Int|   Int|     Int|  Int| Float|Float|    Float|
|           100% Bran|          N|          C|      70|      4|  1|   130|   10|    5|     6|   280|      25|    3|     1| 0.33|68.402973|
|   100% Natural Bran|          Q|          C|     120|      3|  5|    15|    2|    8|     8|   135|       0|    3|     1|    1|33.983679|
|            All-Bran|          K|          C|      70|      4|  1|   260|    9|    7|     5|   320|      25|    3|     1| 0.33|59.425505|
|All-Bran with Ext...|          K|          C|      50|      4|  0|   140|   14|    8|     0|   330|      25|    3|     1|  0.5|93.704912|
|      Almond Delight|          R|          C|     110|      2|  2|   200|    1|   14|     8|    -1|      25|    3|     1| 0.75|34.384843|
|Apple Cinnamon Ch...|          G|          C|     110|      2|  2|   180|  1.5| 10.5|    10|    70|      25|    1|     1| 0.75|29.509541|
|         Apple Jacks|          K|          C|     110|      2|  0|   125|    1|   11|    14|    30|      25|    2|     1|    1|33.174094|
|             Basic 4|          G|          C|     130|      3|  2|   210|    2|   18|     8|   100|      25|    3|  1.33| 0.75|37.038562|
|           Bran Chex|          R|          C|      90|      2|  1|   200|    4|   15|     6|   125|      25|    1|     1| 0.67|49.120253|
+--------------------+-----------+-----------+--------+-------+---+------+-----+-----+------+------+--------+-----+------+-----+---------+
only showing top 10 rows
```

Commands above start PySpark inside the container and look for files stored in S3 `<bucket>/ds1/refined`
PS. You should avoid running local PySpark on large datasets!

## Disclaimer

Please keep in mind that IAM roles used in this example are very broad and should not be used as is.
