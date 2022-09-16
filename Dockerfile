FROM ubuntu:20.04

ARG REPO_URL=https://github.com/akmaru/docker-template.git

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG C.UTF-8
ENV PYTHONIOENCODING=utf-8

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN --mount=type=secret,id=git_username \
    --mount=type=secret,id=git_access_token \
    GIT_USERNAME=$(cat /run/secrets/git_username) \
    && GIT_ACCESS_TOKEN=$(cat /run/secrets/git_access_token) \
    && AUTH_REPO_URL=$(echo ${REPO_URL} | sed -e "s/:\/\//:\/\/${GIT_USERNAME}:${GIT_ACCESS_TOKEN}@/") \
    && git clone ${AUTH_REPO_URL}

WORKDIR $PWD/docker-template
ENTRYPOINT ["bash", "./hello.sh"]
