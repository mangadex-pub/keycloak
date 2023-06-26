# Keycloak

Keycloak is a powerful identity provider and OpenID Connect server.

To ensure continued support of our users without needing them to ever reset their passwords, we must support Argon2id and BCrypt password hashes.

For continued support of legacy user credentials, we need to support some out-of-tree hash algorithms as well, and this is what this image provides us.

## Password hash providers included

Argon2 (& variants) support from: https://github.com/mangadex-pub/keycloak-argon2

BCrypt support from: https://github.com/mangadex-pub/keycloak-bcrypt

## Images and tags published

Images are published with the tag `$TAG-kc$KEYCLOAK_VERSION`.

For example

    ghcr.io/mangadex-pub/keycloak:1.0.4-kc20.0.2
