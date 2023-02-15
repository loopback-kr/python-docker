FROM python:3.11.2-slim

### Settings for development environment
# Change default Shell to bash
SHELL ["/bin/bash", "-c"]
ENV TZ=Asia/Seoul
ENV PYTHONIOENCODING=UTF-8
# Add bash shell prompt color of root account
RUN echo "PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]# '" >> /root/.bashrc
# Change Ubuntu repository address to Kakao server in Republic of Korea
RUN sed -i "s|http://deb.debian.org/debian |https://mirror.kakao.com/debian |g" /etc/apt/sources.list
# Add Bash alias
RUN echo 'alias ll="ls -alh --full-time"' >> ~/.bashrc
RUN echo 'alias cls="clear"' >> ~/.bashrc
# Configure default Pypi repository address and default progress bar style
RUN mkdir -p ~/.config/pip &&\
    echo -e \
"[global]\n"\
"index-url=https://mirror.kakao.com/pypi/simple/\n"\
"trusted-host=mirror.kakao.com\n"\
    > ~/.config/pip/pip.conf &&\
    pip install --no-cache-dir -U pip

RUN apt update -qq &&\
    apt install -qqy \
        vim\
        git

RUN apt clean &&\
    rm -rf /var/lib/apt/lists/*
