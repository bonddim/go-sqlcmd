FROM --platform=${BUILDPLATFORM} alpine:3 AS tools
ARG SQLCMD_VERSION=v1.8.0
ARG TARGETARCH
RUN apk add --update-cache --no-cache curl jq xz && \
  curl -sSL $(curl -sSL "https://api.github.com/repos/microsoft/go-sqlcmd/releases/tags/${SQLCMD_VERSION}" | \
  jq -r --arg arch "${TARGETARCH}" '.assets[] | select(.name | test(".*linux.*" + $arch + ".*")).browser_download_url') \
  | tar -xj

FROM gcr.io/distroless/static:nonroot@sha256:d71f4b239be2d412017b798a0a401c44c3049a3ca454838473a4c32ed076bfea
COPY --from=tools /sqlcmd /sqlcmd
USER nonroot:nonroot
ENTRYPOINT ["/sqlcmd"]
