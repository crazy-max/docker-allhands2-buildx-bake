# myapp

`myapp` built with goreleaser-xx and buildx bake!

## Build

```shell
git clone https://github.com/crazy-max/docker-buildx-bake-demo.git bake-demo
cd bake-demo/demo

# build docker image and output to docker with myapp:local tag (default)
docker buildx bake

# build multi-platform image
docker buildx bake image-all

# create the artifact matching your current platform in ./dist
docker buildx bake artifact

# create artifacts in ./dist
docker buildx bake artifact-all
```

## License

MIT. See `LICENSE` for more details.
