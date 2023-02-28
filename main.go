package main

import (
	"github.com/gin-gonic/gin"
)

var (
	GitTag  = ""
	GitHash = ""
)

func main() {
	r := gin.Default()

	r.GET("/version", func(c *gin.Context) {
		if GitTag == "" {
			c.JSON(200, GitHash)
		} else {
			c.JSON(200, GitTag)
		}
	})
	r.Run("0.0.0.0:9060") // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}
