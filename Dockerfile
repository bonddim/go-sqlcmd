FROM --platform=${BUILDPLATFORM} alpine:3 AS tools
ARG SQLCMD_VERSION=v1.8.2
ARG TARGETARCH
RUN apk add --update-cache --no-cache curl jq xz && \
  curl -sSL https://github.com/microsoft/go-sqlcmd/releases/download/${SQLCMD_VERSION}/sqlcmd-linux-${TARGETARCH}.tar.bz2 \
  | tar -xj

FROM gcr.io/distroless/static:nonroot@sha256:b35229a3a6398fe8f86138c74c611e386f128c20378354fc5442811700d5600d
COPY --from=tools /sqlcmd /sqlcmd
USER 65532:65532
ENTRYPOINT ["/sqlcmd"]
