# docker-bamboo-server with rancher
Atlassian Bamboo in a Docker container with docker side by side

Big Thanks to isso: https://github.com/cptactionhank/docker-atlassian-bamboo/issues/11

isoos commented 27 days ago • 
Here is my config that allowed to install docker inside the image:

```
FROM cptactionhank/atlassian-bamboo:6.3.1
ARG DOCKER_GID
USER root
RUN apk add --no-cache git-lfs shadow docker

RUN groupmod -g ${DOCKER_GID} docker && \
    usermod -aG docker daemon
USER daemon

EXPOSE 8085 54663
VOLUME ["/var/atlassian/bamboo","/opt/atlassian/bamboo/logs"]
WORKDIR /var/atlassian/bamboo
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/opt/atlassian/bamboo/bin/start-bamboo.sh", "-fg"]
```

Also, the docker-compose needs the following instead of the image key:

```
    build:
      context: .
      dockerfile: bamboo-dockerfile
      args:
        DOCKER_GID: 116
```

116 was the GID on my server.

Many thanks to @cguentherTUChemnitz for providing the base work for this.


Mounting Volumes in Bamboo: Ensure the host has the exact path to dockerized bamboo:
sudo ln -s /srv/bamboo/data /var/atlassian/bamboo 



