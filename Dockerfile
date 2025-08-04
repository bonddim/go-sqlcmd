FROM --platform=${BUILDPLATFORM} alpine:3 AS tools
ARG SQLCMD_VERSION=v1.9.0
ARG TARGETARCH
RUN apk add --update-cache --no-cache curl jq xz && \
  curl -sSL https://github.com/microsoft/go-sqlcmd/releases/download/${SQLCMD_VERSION}/sqlcmd-linux-${TARGETARCH}.tar.bz2 \
  | tar -xj

FROM gcr.io/distroless/static:nonroot@sha256:cdf4daaf154e3e27cfffc799c16f343a384228f38646928a1513d925f473cb46
COPY --from=tools /sqlcmd /sqlcmd
USER 65532:65532
ENTRYPOINT ["/sqlcmd"]
