---
marp: true
title: buildx bake adoption --push
description: First use of `bake` in your workflow
theme: default
class:
  - lead
  - invert
paginate: true
_paginate: false
footer: 'github.com/crazy-max'
---

<style scoped>
footer a { color: #404040; }
</style>
![bg 40% opacity blur](assets/docker.png)

# `buildx bake adoption --push`

### First use of `buildx bake` in your workflow.

<!-- This is presenter note. You can write down notes through HTML comment. -->

---

<style scoped>
footer a { color: #404040; }
</style>
![bg 40% opacity blur](assets/docker.png)

# What is Docker buildx?

* New builder as CLI plugin available since Docker 19.03
* `docker buildx build ` <> `docker build` 
* But with many new features
  * Scoped builder instances
  * Building against multiple nodes concurrently
  * External cache source for your build
  * Building multi-platform images
  * Full [BuildKit](https://github.com/moby/buildkit) capabilities with container driver
  * :rocket: High-level build command with **`bake`**

<!-- Docker Buildx is a CLI plugin that extends the docker command with the full support of the features provided by Moby BuildKit builder toolkit -->
<!-- It provides the same user experience as docker build -->
<!-- But with many new features like creating scoped builder instances and building against multiple nodes concurrently -->
<!-- External cache source like the registry using a cache manifest, or local files, ... -->
<!-- Multi-platform images like `linux/amd64`, `linux/arm64` with a single command. No more operations with docker manifest. -->

---

<style scoped>
footer a { color: #404040; }
li { font-size: 90%; }
ul { list-style-type: none; }
</style>
![bg 40% opacity blur](assets/docker.png)

# A buildx command in the wild

* `docker buildx build \`
  * `--push \`
  * `--cache-from "type=registry,ref=foo/myapp" \`
  * `--cache-to "type=inline" \`
  * `--platform "linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64" \`
  * `--label "org.opencontainers.image.title=myapp" \`
  * `--label "org.opencontainers.image.source=https://github.com/foo/myapp" \`
  * `--label "org.opencontainers.image.version=1.0.0" \`
  * `--label "org.opencontainers.image.licenses=Apache-2.0" \`
  * `--tag "foo/myapp:v1.0.0" \`
  * `--tag "foo/myapp:latest" \`
  * `--file "./main.Dockerfile" \`
  * `.`

<!-- As usual to start a build we do this  -->
<!-- But hey we could use some external cache through Docker Hub! -->
<!-- Yeah I want to add support for more platforms -->
<!-- Ok let's add some annotations to be compliant with the OCI Image Format Specification -->
<!-- Tag it -->
<!-- Push it -->
<!-- Choose our Dockerfile -->
<!-- And the context -->

---

<style scoped>
footer a { color: #404040; }
li { font-size: 90%; }
ul { list-style-type: none; }
</style>
![bg 40% opacity blur](assets/docker.png)

# With `bake`

* `docker buildx bake \`
  * `--push`
  * ~~`--cache-from "type=registry,ref=foo/myapp" \`~~
  * ~~`--cache-to "type=inline" \`~~
  * ~~`--platform "linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64" \`~~
  * ~~`--label "org.opencontainers.image.title=myapp" \`~~
  * ~~`--label "org.opencontainers.image.source=https://github.com/foo/myapp" \`~~
  * ~~`--tag "foo/myapp:v1.0.0" \`~~
  * ~~`--tag "foo/myapp:latest" \`~~
  * ~~`--file "./main.Dockerfile" \`~~
  * ~~`.`~~

<!-- As you can see bake will remove all the constraint related to the flags that we need for our build. -->
<!-- Also you don't actually need --push as well but we recommend it as it is a simple way to switch in command line in your CI for example (PR vs master branch) -->

---

<style scoped>
footer a { color: #404040; }
</style>
![bg 40% opacity blur](assets/docker.png)

## bake definition

* Can be a Docker Compose, JSON or **HCL** :heart: file
* Multiple files can be specified with `--file` flag
  * Configurations are merged
* Default to
  * Compose: `docker-compose.yml`, `docker-compose.yaml`
  * JSON: `docker-bake.json`, `docker-bake.override.json`
  * HCL: `docker-bake.hcl`, `docker-bake.override.hcl`

<!-- With bake we want to let the users define project specific reusable build flows that can then be easily invoked by anyone using a definition file. -->
<!-- Yeah HCL that's the way x) -->
<!-- Merged with the specified order -->
<!-- Default to the following if not specified -->

---

<style scoped>
footer a { color: #404040; }
code { font-size: 70%; }
</style>
![bg 40% opacity blur](assets/docker.png)

## HCL format

`docker buildx bake image-all`

```hcl
group "default" {
  targets = ["image"]
}

target "image" {
  context = "."
  dockerfile = "./main.Dockerfile"
  cache-from = "type=registry,ref=foo/myapp"
  cache-to = "type=inline"
  labels = [
    "org.opencontainers.image.title=myapp",
    "org.opencontainers.image.title=https://github.com/foo/myapp"
  ]
  tags = [
    "foo/myapp:v1.0.0",
    "foo/myapp:latest"
  ]
}

target "image-all" {
  inherits = ["image"]
  platforms = [ "linux/amd64", "linux/arm/v6", "linux/arm/v7", "linux/arm64" ]
}
```

<!-- HCL adds support for custom build rules allowing better code reuse and different target groups. -->

---

<style scoped>
footer a { color: #404040; }
</style>
![bg 40%](assets/demo-time.jpg)

<!-- Let's jump to the demo! -->

---

<style scoped>
footer a { color: #404040; }
</style>
![bg 20% opacity blur](https://avatars1.githubusercontent.com/u/1951866?v=4)

# Thanks for your time!

* :test_tube: Bake is still experimental but please give us [your feedback](https://github.com/docker/buildx/issues) if you want to use it!
* :newspaper: Slides and demo available [on GitHub](https://github.com/crazy-max/docker-buildx-bake-demo)
* :whale: Check out [Diun project](https://github.com/crazy-max/diun) as a complete example of using bake

<!-- The design of bake is in very early stages and we are looking for feedback from users -->
