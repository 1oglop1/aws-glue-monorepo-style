def test_get_glue_args():
    from types import ModuleType
    import sys

    sys_argv = ["--APP_SETTINGS_ENVIRONMENT", "dev", "--JOB_NAME", "job"]
    expected = {"APP_SETTINGS_ENVIRONMENT": "dev", "JOB_NAME": "job"}

    def getResolvedOptions(args, options):
        """Fake version of awsglue.utils.getResolvedOptions."""
        return {"APP_SETTINGS_ENVIRONMENT": "dev", "JOB_NAME": "job"}

    sys.modules["awsglue.utils"] = ModuleType("awsglue.utils")
    sys.modules["awsglue.utils"].getResolvedOptions = getResolvedOptions

    from glue_shared import get_glue_args

    assert get_glue_args(sys_argv, ["APP_SETTINGS_ENVIRONMENT"]) == expected
