FROM --platform=${BUILDPLATFORM} alpine:3 AS tools
ARG SQLCMD_VERSION=v1.8.0
ARG TARGETARCH
RUN apk add --update-cache --no-cache curl jq xz && \
  curl -sSL $(curl -sSL "https://api.github.com/repos/microsoft/go-sqlcmd/releases/tags/${SQLCMD_VERSION}" | \
  jq -r --arg arch "${TARGETARCH}" '.assets[] | select(.name | test(".*linux.*" + $arch + ".*")).browser_download_url') \
  | tar -xj

FROM gcr.io/distroless/static:nonroot@sha256:3a03fc0826340c7deb82d4755ca391bef5adcedb8892e58412e1a6008199fa91
COPY --from=tools /sqlcmd /sqlcmd
USER nonroot:nonroot
ENTRYPOINT ["/sqlcmd"]
