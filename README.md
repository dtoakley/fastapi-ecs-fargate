# fastapi-ecs-fargate

# Pre-requisites 

- Homebrew - install [here](https://brew.sh/)
- Python >= 3.10.x - recommend using [pyenv](https://github.com/pyenv/pyenv) or [pipenv](https://github.com/pypa/pipenv) to manage local Python versions
- Terraform >= 1.0.0 - recommend using [tfenv](https://github.com/tfutils/tfenv) to manage local terraform versions
- Colima for container runtimes on macOS - install [here](https://github.com/abiosoft/colima)

# Installation
- Ensure you have Python 3.10.4 configured as you local Python version, then run:

```shell
$ python -m venv venv
$ pip install -r requirements.txt
```

# Docker: build and run locally

Ensure Colima is running in the background:

```shell
$ colima start
```

To build the Docker image locally:

```shell
$ docker build -t fastapi-eca-fargate .
```

To run the image locally:

```shell
$ docker run -d --name fastapi-container -p 80:80 fastapi-eca-fargate
```


TODO:
- DynamoDB for state locking 
- Assume role for executing Terraform
- Policy for assumed role 
