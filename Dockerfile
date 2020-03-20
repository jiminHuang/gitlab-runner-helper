FROM ubuntu

# gitlab-runner-helper will try to resolve `sh` from the path. We ensure the PATH is populated by default, as some container runtimes do no longer set a default (e.g. containerd v1.2.8)
ENV PATH="${PATH:-/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin}"

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y ca-certificates wget apt-transport-https vim git curl git-lfs perl && \
    rm -rf /var/lib/apt/lists/*

RUN git lfs install --skip-repo

COPY ./scripts/ /usr/bin
COPY ./binaries/gitlab-runner-helper /usr/bin/gitlab-runner-helper

RUN echo 'hosts: files dns' >> /etc/nsswitch.conf

CMD ["sh"]
