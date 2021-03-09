# syntax=docker/dockerfile:1.2

FROM marpteam/marp-cli AS base

FROM base AS generate
RUN --mount=type=bind,source=./slides,target=. \
  node /home/marp/.cli/marp-cli.js -o /tmp/slides/index.html . \
  && cp -Rf ./assets /tmp/slides/ \
  && ls -al /tmp/slides

FROM scratch AS release
COPY --from=generate /tmp/slides/ /
