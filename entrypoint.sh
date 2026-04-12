#!/bin/sh
set -eu

: "${DSN:?Missing DSN}"
: "${KRATOS_PUBLIC_URL:?Missing KRATOS_PUBLIC_URL}"
: "${SELF_SERVICE_UI_URL:?Missing SELF_SERVICE_UI_URL}"
: "${DEFAULT_SECRET:?Missing DEFAULT_SECRET}"
: "${COOKIE_SECRET:?Missing COOKIE_SECRET}"
: "${CIPHER_SECRET:?Missing CIPHER_SECRET}"
: "${OIDC_PROVIDERS_GOOGLE_CLIENT_ID:?Missing OIDC_PROVIDERS_GOOGLE_CLIENT_ID}"
: "${OIDC_PROVIDERS_GOOGLE_CLIENT_SECRET:?Missing OIDC_PROVIDERS_GOOGLE_CLIENT_SECRET}"
: "${DOMAIN_COOKIE:?Missing DOMAIN_COOKIE}"
: "${OAUTH2_PROVIDER_URL:?Missing OAUTH2_PROVIDER_URL}"

envsubst < /etc/kratos/kratos.yml.tmpl > /etc/kratos/kratos.yml

if [ "${RUN_MIGRATIONS:-false}" = "true" ]; then
  kratos migrate sql "$DSN" -c /etc/kratos/kratos.yml -e --yes
fi

exec kratos -c /etc/kratos/kratos.yml serve ${KRATOS_EXTRA_ARGS:-}
