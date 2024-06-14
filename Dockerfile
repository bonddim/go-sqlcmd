FROM --platform=${BUILDPLATFORM} alpine:3 AS tools
ARG SQLCMD_VERSION=v1.6.0
ARG TARGETARCH
RUN apk add jq --no-cache && \
  wget -c -O - $(wget -q -O - https://api.github.com/repos/microsoft/go-sqlcmd/releases/tags/${SQLCMD_VERSION} \
  | jq -r --arg arch "${TARGETARCH}" '.assets[] | select(.name | test(".*linux.*" + $arch + ".*")).browser_download_url' ) \
  | tar -xj

FROM gcr.io/distroless/static:nonroot
COPY --from=tools /sqlcmd /sqlcmd
USER nonroot:nonroot
ENTRYPOINT ["/sqlcmd"]
