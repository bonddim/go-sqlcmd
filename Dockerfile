FROM --platform=${BUILDPLATFORM} alpine:3 AS tools
ARG SQLCMD_VERSION=v1.8.2
ARG TARGETARCH
RUN apk add --update-cache --no-cache curl jq xz && \
  curl -sSL https://github.com/microsoft/go-sqlcmd/releases/download/${SQLCMD_VERSION}/sqlcmd-linux-${TARGETARCH}.tar.bz2 \
  | tar -xj

FROM gcr.io/distroless/static:nonroot@sha256:627d6c5a23ad24e6bdff827f16c7b60e0289029b0c79e9f7ccd54ae3279fb45f
COPY --from=tools /sqlcmd /sqlcmd
USER 65532:65532
ENTRYPOINT ["/sqlcmd"]
