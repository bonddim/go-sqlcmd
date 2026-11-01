FROM --platform=${BUILDPLATFORM} busybox:stable AS tools
ARG SQLCMD_VERSION=v1.10.0
ARG TARGETARCH
ADD https://github.com/microsoft/go-sqlcmd/releases/download/${SQLCMD_VERSION}/sqlcmd-linux-${TARGETARCH}.tar.bz2 sqlcmd.tar.bz2
RUN tar -xvf sqlcmd.tar.bz2

FROM gcr.io/distroless/static:nonroot@sha256:25ac8f0c3b2334a9eb05452266bd4697864a8c8ef0ef71e5e6480d7f92868329
COPY --from=tools /sqlcmd /sqlcmd
USER 65532:65532
ENTRYPOINT ["/sqlcmd"]
