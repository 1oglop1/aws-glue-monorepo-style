import moto
import boto3
import pytest


@moto.mock_ssm
def test_resolve_2_valid_parameters():
    from glue_shared.boto3_helpers import resolve_ssm_parameters

    ssm_client = boto3.client("ssm")
    ssm_client.put_parameter(Name="/dev/db/host", Value="127.0.0.1", Type="String")
    ssm_client.put_parameter(Name="/dev/db/password", Value="magic", Type="SecureString")

    actual = resolve_ssm_parameters(
        ssm_client, {"db_host": "/dev/db/host", "db_password": "/dev/db/password"}
    )

    expected = {"db_host": "127.0.0.1", "db_password": "magic"}

    assert actual == expected


@moto.mock_ssm
def test_resolve_12_valid_parameters():
    from glue_shared.boto3_helpers import resolve_ssm_parameters
    from string import ascii_lowercase
    from random import choice

    input_ssm_parameters = {
        letter: (f"/{letter}/{letter}", "value") for letter in ascii_lowercase[:12]
    }
    ssm_client = boto3.client("ssm")
    param_types = ["String", "SecureString"]

    for key, (name, value) in input_ssm_parameters.items():
        ssm_client.put_parameter(Name=name, Value=value, Type=choice(param_types))

    actual = resolve_ssm_parameters(
        ssm_client, {key: name for key, (name, value) in input_ssm_parameters.items()}
    )

    expected = {key: value for key, (name, value) in input_ssm_parameters.items()}
    assert actual == expected
    assert len(actual) == len(expected)


@moto.mock_ssm
def test_resolve_12_valid_1_invalid_parameters():
    from glue_shared.boto3_helpers import resolve_ssm_parameters
    from glue_shared.exceptions import ParametersNotFound
    from string import ascii_lowercase
    from random import choice

    input_ssm_parameters = {
        letter: (f"/{letter}/{letter}", "value") for letter in ascii_lowercase[:12]
    }
    ssm_client = boto3.client("ssm")
    param_types = ["String", "SecureString"]

    for key, (name, value) in input_ssm_parameters.items():
        ssm_client.put_parameter(Name=name, Value=value, Type=choice(param_types))

    input_ssm_parameters.update({"does_not_exist": ("/does/not/exist", "not_exists")})

    with pytest.raises(ParametersNotFound):
        actual = resolve_ssm_parameters(
            ssm_client,
            {key: name for key, (name, value) in input_ssm_parameters.items()},
        )
        expected = {key: value for key, (name, value) in input_ssm_parameters.items()}
        assert actual == expected
        assert len(actual) == len(expected)
