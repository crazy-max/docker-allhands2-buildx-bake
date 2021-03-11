# `bake-demo`

App built with [goreleaser-xx](https://github.com/crazy-max/goreleaser-xx) and [buildx bake](https://github.com/docker/buildx)!

## Build

```shell
git clone https://github.com/crazy-max/docker-buildx-bake-demo.git bake-demo
cd bake-demo

# build docker image and output to docker with bake-demo:local tag (default)
docker buildx bake image-local

# build multi-platform image
docker buildx bake image-all

# create the artifact matching your current platform in ./dist
docker buildx bake artifact

# create artifacts for many platforms in ./dist
docker buildx bake artifact-all
```

## GitHub Actions

GitHub Action workflow available in [.github/workflows/build.yml](../.github/workflows/build.yml)

* Using [docker/bake-action](https://github.com/docker/bake-action) to:
  * Publish artifacts to [GitHub Releases](https://github.com/crazy-max/docker-buildx-bake-demo/releases)
  * Publish multi-platform Docker image to [Docker Hub](https://hub.docker.com/r/crazymax/bake-demo/tags?page=1&ordering=last_updated) and [GHCR](https://github.com/users/crazy-max/packages/container/package/bake-demo)

## License

MIT. See `LICENSE` for more details.
