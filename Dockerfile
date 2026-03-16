FROM --platform=${BUILDPLATFORM} busybox:stable AS tools
ARG SQLCMD_VERSION=v1.10.0
ARG TARGETARCH
ADD https://github.com/microsoft/go-sqlcmd/releases/download/${SQLCMD_VERSION}/sqlcmd-linux-${TARGETARCH}.tar.bz2 sqlcmd.tar.bz2
RUN tar -xvf sqlcmd.tar.bz2

FROM gcr.io/distroless/static:nonroot@sha256:e3f945647ffb95b5839c07038d64f9811adf17308b9121d8a2b87b6a22a80a39
COPY --from=tools /sqlcmd /sqlcmd
USER 65532:65532
ENTRYPOINT ["/sqlcmd"]
