import sys
from types import ModuleType
import datetime
from glue_shared import parse_args


def test_parse_args_pyshell():
    argv = [
        "/tmp/glue-python-scripts-jm72zh6c/jan_pyshell_job.py",
        "--APP_SETTINGS_ENVIRONMENT",
        "dev",
        "--job-bookmark-option",
        "job-bookmark-disable",
        "--job-language",
        "python",
    ]

    actual = parse_args(argv, ["APP_SETTINGS_ENVIRONMENT"])
    expected = {"APP_SETTINGS_ENVIRONMENT": "dev"}
    assert actual == expected


def test_parse_args_glueetl():
    argv = [
        "script_2020-04-15-11-21-57.py",
        "--JOB_NAME",
        "glue-spark-job",
        "--APP_SETTINGS_ENVIRONMENT",
        "dev",
        "--JOB_ID",
        "j_3456789",
        "--JOB_RUN_ID",
        "jr_3456789",
        "--job-bookmark-option",
        "job-bookmark-disable",
        "--TempDir",
        "s3://bucker/Key/dir",
    ]

    sys.modules["dynamicframe"] = ModuleType("DynamicFrame")
    sys.modules["dynamicframe"].DynamicFrame = None
    sys.modules["awsglue.utils"] = ModuleType("awsglue.utils")
    sys.modules["awsglue.utils"].getResolvedOptions = lambda arguments, options=None: {
        "APP_SETTINGS_ENVIRONMENT": "dev",
        "JOB_ID": "j_3456789",
    }

    actual = parse_args(argv, ["APP_SETTINGS_ENVIRONMENT", "JOB_ID"])
    expected = {"APP_SETTINGS_ENVIRONMENT": "dev", "JOB_ID": "j_3456789"}
    assert actual == expected


def test_comma_str_time_2_time_obj():
    from glue_shared.str2obj import comma_str_time_2_time_obj

    input1 = "2020-04-21 03:00"
    input2 = "2020-04-21 03:00, 2020-04-21 04:00"
    input3 = "2020-04-21 03:00,2020-04-20 02:00"

    expected1 = (datetime.datetime(2020, 4, 21, 3, 0),)
    expected2 = (
        datetime.datetime(2020, 4, 21, 3, 0),
        datetime.datetime(2020, 4, 21, 4, 0),
    )

    expected3 = (
        datetime.datetime(2020, 4, 21, 3, 0),
        datetime.datetime(2020, 4, 20, 2, 0),
    )
    assert comma_str_time_2_time_obj(input1) == expected1
    assert comma_str_time_2_time_obj(input2) == expected2
    assert comma_str_time_2_time_obj(input3) == expected3
