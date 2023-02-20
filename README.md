# Python for Asia/Seoul region

Container images for python are available in [loopbackkr's DockerHub repository](https://hub.docker.com/r/loopbackkr/python).

## Quick start

### Docker pulling

`docker pull loopbackkr/python:latest`

`docker pull loopbackkr/python:3.11`

### Dockerfiling

`FROM loopbackkr/python:latest`

`FROM loopbackkr/python:3.11`

## Features

* Use [kakao mirror](https://mirror.kakao.com/) reposistory for apt and pip
* Pretty welcome message with version log
* Colorful bash prompt
* preinstalled vim, git

## References

* [Status of Python Verions](https://devguide.python.org/versions/)