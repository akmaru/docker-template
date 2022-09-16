# Docker Template
An easy template for dockerfile and docker-compose.


## Requirements
* Docker >= 20.10.0
* Docker Compose >= 2.5.0


## Getting started
### 1. Prepare credential files
For example of cloning some private repositories at building docker image, this docker template is cloned own repository.
Therefore, we must to gitlab credential information through docker secret mount option.

(It is no recommended passing credential through ARG or ENV because the values are visible any user with the `docker history` command.)

```console
echo <git-username> > git_username.txt
echo <git-personal-access-token> > git_access_token.txt
```

### 2. Build docker image
#### Case 1. Using Docker
```console
DOCKER_BUILDKIT=1 docker build --secret id=git_username,src=git_username.txt --secret id=git_access_token,src=git_access_token.txt -t docker-template .
```

#### Case 2. Using Docker Compose
```console
docker-compose build
```


### 3. Launch docker container
#### Case 1. Using Docker

```console
docker run --rm docker-template
```

#### Case 2. Using Docker Compose
```console
docker-compose run test
```

You will get the following message.

```
You succeeded to clone this repository at building docker image!
```


## References
* https://docs.docker.com/develop/develop-images/build_enhancements/#new-docker-build-secret-information
* https://docs.docker.com/engine/swarm/secrets/#use-secrets-in-compose
