# Stage 1: take the kratos binary from the official image
FROM oryd/kratos:v25.4.0 AS kratos

# Stage 2: run on alpine so we can install envsubst (gettext)
FROM alpine:3.20

RUN apk add --no-cache ca-certificates gettext

# Copy Kratos binary (in distroless it lives at /usr/bin/kratos)
COPY --from=kratos /usr/bin/kratos /usr/bin/kratos

COPY kratos.yml.tmpl /etc/kratos/kratos.yml.tmpl
COPY identity.schema.json /etc/kratos/identity.schema.json
COPY entrypoint.sh /entrypoint.sh
RUN mkdir -p /etc/kratos/mappers
COPY mappers/google.jsonnet /etc/kratos/mappers/google.jsonnet
RUN chmod +x /entrypoint.sh

EXPOSE 4433 4434
ENTRYPOINT ["/entrypoint.sh"]
