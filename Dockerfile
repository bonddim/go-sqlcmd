FROM --platform=${BUILDPLATFORM} alpine:3 AS tools
# renovate: datasource=github-releases depName=sqlcmd packageName=microsoft/go-sqlcmd
ARG SQLCMD_VERSION=v1.6.0
ARG TARGETARCH
RUN wget -c https://github.com/microsoft/go-sqlcmd/releases/download/${VERSION}/sqlcmd-${VERSION}-linux-${TARGETARCH}.tar.bz2 -O - | tar -xj

FROM gcr.io/distroless/static:nonroot
COPY --from=tools /sqlcmd /sqlcmd
USER nonroot:nonroot
ENTRYPOINT ["/sqlcmd"]
