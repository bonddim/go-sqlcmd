FROM --platform=${BUILDPLATFORM} busybox:stable AS tools
ARG SQLCMD_VERSION=v1.10.0
ARG TARGETARCH
ADD https://github.com/microsoft/go-sqlcmd/releases/download/${SQLCMD_VERSION}/sqlcmd-linux-${TARGETARCH}.tar.bz2 sqlcmd.tar.bz2
RUN tar -xvf sqlcmd.tar.bz2

FROM gcr.io/distroless/static:nonroot@sha256:d62067879de890a1def9da0e7766b7d20810a5e5555cef8506b752437d7a3e88
COPY --from=tools /sqlcmd /sqlcmd
USER 65532:65532
ENTRYPOINT ["/sqlcmd"]
