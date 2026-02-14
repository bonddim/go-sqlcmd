FROM --platform=${BUILDPLATFORM} busybox:stable AS tools
ARG SQLCMD_VERSION=v1.9.0
ARG TARGETARCH
ADD https://github.com/microsoft/go-sqlcmd/releases/download/${SQLCMD_VERSION}/sqlcmd-linux-${TARGETARCH}.tar.bz2 sqlcmd.tar.bz2
RUN tar -xvf sqlcmd.tar.bz2

FROM gcr.io/distroless/static:nonroot@sha256:01e550fdb7ab79ee7be5ff440a563a58f1fd000ad9e0c532e65c3d23f917f1c5
COPY --from=tools /sqlcmd /sqlcmd
USER 65532:65532
ENTRYPOINT ["/sqlcmd"]
