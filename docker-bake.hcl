group "default" {
  targets = ["slides"]
}

target "slides" {
  dockerfile = "./slides.Dockerfile"
  target = "release"
  output = ["./www"]
}
