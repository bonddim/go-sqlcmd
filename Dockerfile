FROM --platform=${BUILDPLATFORM} alpine:3 AS tools
ARG SQLCMD_VERSION=v1.6.0
ARG TARGETARCH
RUN wget -c https://github.com/microsoft/go-sqlcmd/releases/download/${SQLCMD_VERSION}/sqlcmd-${SQLCMD_VERSION}-linux-${TARGETARCH}.tar.bz2 -O - | tar -xj

FROM gcr.io/distroless/static:nonroot
COPY --from=tools /sqlcmd /sqlcmd
USER nonroot:nonroot
ENTRYPOINT ["/sqlcmd"]
