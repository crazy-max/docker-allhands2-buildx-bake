package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"runtime"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

var (
	name    = "bake-demo"
	version = "dev"
	commit  = ""
	date    = ""
)

func main() {
	log.SetFlags(0)

	if len(os.Args) >= 2 {
		switch os.Args[1] {
		case "--version", "-v":
			fmt.Printf("%s/%s\n", name, version)
			os.Exit(0)
		}
	}

	// Echo
	e := echo.New()
	e.Logger.Infof("Starting %s/%s commit/%s date/%s go/%s %s/%s", name, version, commit, date, runtime.Version()[2:], runtime.GOOS, runtime.GOARCH)
	e.Use(middleware.LoggerWithConfig(middleware.LoggerConfig{
		Format: "[${time_rfc3339}] ${status} ${method} ${path} (${remote_ip}) ${latency_human}\n",
		Output: e.Logger.Output(),
	}))
	e.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, fmt.Sprintf("Hello, you've requested: %s\n", c.Request().URL.Path))
	})
	e.Logger.Fatal(e.Start(":8080"))
}
