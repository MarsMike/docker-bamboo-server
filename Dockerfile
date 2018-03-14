FROM cptactionhank/atlassian-bamboo:latest
ARG DOCKER_GID=994
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
