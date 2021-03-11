# syntax=docker/dockerfile:1.2

FROM --platform=$BUILDPLATFORM crazymax/goreleaser-xx:latest AS goreleaser-xx
FROM --platform=$BUILDPLATFORM golang:alpine AS base
COPY --from=goreleaser-xx / /
RUN apk add --no-cache git
WORKDIR /src

FROM base AS build
ARG TARGETPLATFORM
ARG GIT_REF
RUN --mount=type=bind,source=.,target=/src,rw \
  --mount=type=cache,target=/root/.cache/go-build \
  --mount=type=cache,target=/go/pkg/mod \
  goreleaser-xx --debug \
    --name="bake-demo" \
    --dist="/out" \
    --hooks="go mod tidy" \
    --hooks="go mod download" \
    --main="." \
    --ldflags="-s -w -X 'main.version={{.Version}}' -X main.commit={{.Commit}} -X main.date={{.Date}}" \
    --files="LICENSE" \
    --files="README.md"

FROM scratch AS artifact
COPY --from=build /out/*.tar.gz /
COPY --from=build /out/*.zip /

FROM alpine
LABEL maintainer="CrazyMax"
RUN apk --update --no-cache add \
    ca-certificates \
    libressl \
    shadow \
  && addgroup -g 1000 bake-demo \
  && adduser -u 1000 -G bake-demo -s /sbin/nologin -D bake-demo
COPY --from=build /usr/local/bin/bake-demo /usr/local/bin/bake-demo
RUN bake-demo --version
USER bake-demo
EXPOSE 8080
ENTRYPOINT [ "bake-demo" ]
