# Keycloak

Keycloak is a powerful identity provider and OpenID Connect server.

To ensure continued support of our users without needing them to ever reset their passwords, we must support Argon2id and BCrypt password hashes.

Additionally, we always run on mainline runtimes, or at least latest LTS. And at the moment Keycloak's upstream image still relies on Java 11 despite support
for Java 17. We appreciate that some ~~damaged~~ people will stick to abandonware like their life depends on it, but this isn't our style. So we will always run
the latest possible JDK that Keycloak supports.

This this what this repo mainly aims to provide.

## Password hash providers included

Argon2 (& variants) support from: https://github.com/mangadex-pub/keycloak-argon2

BCrypt support from: https://github.com/mangadex-pub/keycloak-bcrypt

## Images and tags published

Three flavours of image are produced:

1. A "vanilla" image, without extra configuration on top of the official distribution:
    - `$TAG-kc$KEYCLOAK_VERSION-vanilla`
2. A PostgreSQL-configured cache-less image (mainly for local development):
    - `$TAG-kc$KEYCLOAK_VERSION-pgsql`
3. A PostgreSQL + Kubernetes Infinispan configured image (for our production runtime):
    - `$TAG-kc$KEYCLOAK_VERSION-pgsql-k8s`
