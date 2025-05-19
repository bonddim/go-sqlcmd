FROM --platform=${BUILDPLATFORM} alpine:3 AS tools
ARG SQLCMD_VERSION=v1.8.2
ARG TARGETARCH
RUN apk add --update-cache --no-cache curl jq xz && \
  curl -sSL https://github.com/microsoft/go-sqlcmd/releases/download/${SQLCMD_VERSION}/sqlcmd-linux-${TARGETARCH}.tar.bz2 \
  | tar -xj

FROM gcr.io/distroless/static:nonroot@sha256:188ddfb9e497f861177352057cb21913d840ecae6c843d39e00d44fa64daa51c
COPY --from=tools /sqlcmd /sqlcmd
USER 65532:65532
ENTRYPOINT ["/sqlcmd"]
