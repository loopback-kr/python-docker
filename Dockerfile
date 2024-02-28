FROM python:3.12-slim

# Change default Shell to bash
SHELL ["/bin/bash", "-c"]
# Set environment variables
ENV TZ=Asia/Seoul
ENV PYTHONIOENCODING=UTF-8
# Add bash shell prompt color of root
RUN echo "PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]# '" >> /root/.bashrc
# Change Ubuntu repository to Kakao mirror
RUN sed -i "s|http://deb.debian.org/debian |https://mirror.kakao.com/debian |g" /etc/apt/sources.list.d/debian.sources
# Add Bash alias
RUN echo 'alias ll="ls -alh --full-time"' >> ~/.bashrc
RUN echo 'alias cls="clear"' >> ~/.bashrc
# Add welcome message
RUN echo "echo -e '\x1b[0;34m                  _____ ______                                                  \n________ _____  ____  /____  /_ ______ _______                                  \n___  __ \__  / / /_  __/__  __ \_  __ \__  __ \                                 \n__  /_/ /_  /_/ / / /_  _  / / // /_/ /_  / / /                                 \n_  .___/ _\__, /  \__/  /_/ /_/ \____/ /_/ /_/                                  \n/_/      /____/                                  \x1b[0;94m                               '" >> ~/.bashrc
RUN echo "echo -e '\n\x1b[0;33m'\$(sed -n '/^NAME=/p' /etc/os-release | cut -d '\"' -f 2)'\t'\$(sed -n '/VERSION=/p' /etc/os-release | cut -d '\"' -f 2)" >> ~/.bashrc
RUN echo "echo -e 'Python \t\t\t'\$(python -V | cut -d ' ' -f 2)" >> ~/.bashrc
RUN echo "echo -e 'Pip \t\t\t'\$(pip -V | cut -d '(' -f 1 | cut -d ' ' -f 2-)" >> ~/.bashrc
RUN echo "echo -e '\t\t\t'\$(sed -n '/index-url/p' ~/.config/pip/pip.conf)" >> ~/.bashrc
# Configure default Pypi repository with Kakao mirror
RUN mkdir -p ~/.config/pip &&\
    echo -e \
"[global]\n"\
"index-url=https://mirror.kakao.com/pypi/simple/\n"\
"extra-index-url=https://pypi.org/simple/\n"\
"trusted-host=mirror.kakao.com\n"\
    > ~/.config/pip/pip.conf &&\
    pip install --no-cache-dir -U pip
# Install additional packages
RUN apt update -qq &&\
    apt install -qqy \
        vim\
        git
# Clean cache
RUN apt clean &&\
    rm -rf /var/lib/apt/lists/*