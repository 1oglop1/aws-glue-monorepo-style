from setuptools import setup, find_packages

setup(
    name="glue_shared",
    author="Jan Gazda",
    author_email="jan.gazda@cloudreach.com",
    python_requires=">=3.6",
    classifiers=[
        "Development Status :: 2 - Pre-Alpha",
        "Intended Audience :: Developers",
        "Natural Language :: English",
        "Programming Language :: Python :: 3.6",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
    ],
    description="Helper library for AWS Glue jobs.",
    setup_requires=["wheel"],
    package_dir={"": "src"},
    packages=find_packages(where="src", exclude=["contrib", "docs", "tests"]),
    test_suite="tests",
    version="0.0.1",
    zip_safe=True,
)
