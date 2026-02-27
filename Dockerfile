FROM --platform=${BUILDPLATFORM} busybox:stable AS tools
ARG SQLCMD_VERSION=v1.9.0
ARG TARGETARCH
ADD https://github.com/microsoft/go-sqlcmd/releases/download/${SQLCMD_VERSION}/sqlcmd-linux-${TARGETARCH}.tar.bz2 sqlcmd.tar.bz2
RUN tar -xvf sqlcmd.tar.bz2

FROM gcr.io/distroless/static:nonroot@sha256:f512d819b8f109f2375e8b51d8cfd8aafe81034bc3e319740128b7d7f70d5036
COPY --from=tools /sqlcmd /sqlcmd
USER 65532:65532
ENTRYPOINT ["/sqlcmd"]
