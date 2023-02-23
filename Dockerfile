# Loosely based on https://github.com/keycloak/keycloak/blob/315f02483279cdaa2634742c039b4cf8111d18ef/quarkus/container/Dockerfile
# First stage gathers all jars necessary
FROM registry.access.redhat.com/ubi9 as keycloak-build

RUN dnf install -y tar gzip
ADD ubi-null.sh /tmp/
RUN bash /tmp/ubi-null.sh java-17-openjdk-headless glibc-langpack-en

ARG KEYCLOAK_VERSION="21.0.0"
ARG KEYCLOAK_MD_BUILD="1"
ARG KEYCLOAK_DIST="https://github.com/mangadex-pub/keycloak-upstream/releases/download/${KEYCLOAK_VERSION}-mangadex-${KEYCLOAK_MD_BUILD}/keycloak-${KEYCLOAK_VERSION}.tar.gz"
ADD ${KEYCLOAK_DIST} /tmp/keycloak/

WORKDIR /tmp/keycloak
RUN tar -xvf /tmp/keycloak/keycloak-*.tar.gz && \
    rm -v /tmp/keycloak/keycloak-*.tar.gz && \
    mv /tmp/keycloak/keycloak-* /opt/keycloak && \
    mkdir -p /opt/keycloak/data && \
    chmod -R g+rwX /opt/keycloak

ARG KEYCLOAK_ARGON2_VERSION="3.1.0"
ARG KEYCLOAK_ARGON2_DIST="https://github.com/mangadex-pub/keycloak-argon2/releases/download/${KEYCLOAK_ARGON2_VERSION}/keycloak-argon2-${KEYCLOAK_ARGON2_VERSION}.jar"
ADD ${KEYCLOAK_ARGON2_DIST} "/opt/keycloak/providers/keycloak-argon2-${KEYCLOAK_ARGON2_VERSION}.jar"

ARG KEYCLOAK_BCRYPT_VERSION="1.6.0"
ARG KEYCLOAK_BCRYPT_DIST="https://github.com/mangadex-pub/keycloak-bcrypt/releases/download/${KEYCLOAK_BCRYPT_VERSION}/keycloak-bcrypt-${KEYCLOAK_BCRYPT_VERSION}.jar"
ADD ${KEYCLOAK_BCRYPT_DIST} "/opt/keycloak/providers/keycloak-bcrypt-${KEYCLOAK_BCRYPT_VERSION}.jar"

RUN chmod -v 0644 /opt/keycloak/providers/*.jar

FROM registry.access.redhat.com/ubi9-micro
ENV LANG en_US.UTF-8

RUN echo "keycloak:x:0:root" >> /etc/group && \
    echo "keycloak:x:1000:0:keycloak user:/opt/keycloak:/sbin/nologin" >> /etc/passwd
USER 1000

COPY --from=keycloak-build /tmp/null/rootfs/ /
COPY --from=keycloak-build --chown=1000:0 /opt/keycloak /opt/keycloak

ENTRYPOINT [ "/opt/keycloak/bin/kc.sh" ]
