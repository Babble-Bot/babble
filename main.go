package main

import (
	"net/http"

	"github.com/gin-gonic/contrib/static"
	"github.com/gin-gonic/gin"
)

type Response struct {
	Message string `json:"message"`
}

func main() {
	gin.SetMode(gin.ReleaseMode)
	router := gin.Default()
	// Serve the frontend
	router.Use(static.Serve("/", static.LocalFile("./app/build/web", true)))

	api := router.Group("/api")
	{
		api.GET("/theta/:userId", func(c *gin.Context) {
			var channel Channels
			if err := c.ShouldBindUri(&channel); err != nil {
				c.JSON(http.StatusBadRequest, gin.H{"msg": err})
				return
			}
			c.JSON(http.StatusOK, gin.H{"uid": channel.userId})
		})
		// api.GET("/jokes", authMiddleware(), JokeHandler)
		// api.POST("/jokes/like/:jokeID", authMiddleware(), LikeJoke)
	}
	// Start the app
	router.Run(":80")
}
