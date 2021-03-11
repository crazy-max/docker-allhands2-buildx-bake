// GitHub reference as defined in GitHub Actions (eg. refs/head/master))
variable "GITHUB_REF" {
  default = ""
}

target "git-ref" {
  args = {
    GIT_REF = GITHUB_REF
  }
}

// Special target: https://github.com/crazy-max/ghaction-docker-meta#bake-definition
target "ghaction-docker-meta" {
  tags = ["bake-demo:local"]
}

group "default" {
  targets = ["slides"]
}

target "slides" {
  dockerfile = "./slides.Dockerfile"
  target = "release"
  output = ["./www"]
}

target "context" {
  context = "./demo"
}

target "image" {
  inherits = ["context", "git-ref", "ghaction-docker-meta"]
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
}

target "image-all" {
  inherits = ["image"]
  platforms = [
    "linux/amd64",
    "linux/arm/v6",
    "linux/arm/v7",
    "linux/arm64",
    "linux/ppc64le"
  ]
}

target "artifact" {
  inherits = ["context", "git-ref"]
  target = "artifact"
  output = ["./dist"]
}

target "artifact-all" {
  inherits = ["artifact"]
  platforms = [
    "linux/amd64",
    "linux/arm/v5",
    "linux/arm/v6",
    "linux/arm/v7",
    "linux/arm64",
    "linux/386",
    "linux/ppc64le",
    "windows/amd64",
    "windows/386",
    "darwin/amd64",
    "freebsd/amd64",
    "freebsd/386"
  ]
}
