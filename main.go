package main

import (
	"github.com/Babble-Bot/babble/controllers"
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

	api := router.Group("/api/theta")
	{
		api.GET("/channels/:userId", controllers.FindChannel)
		api.GET("/installs", controllers.GetInstalls)
		// api.POST("/channel/:userid/*action")
		// api.POST("/channel/alertconfig/:userId/*config")
		// api.POST("/channel/sociallinks/:userId/*link")
		// api.GET("/jokes", authMiddleware(), JokeHandler)
		// api.POST("/jokes/like/:jokeID", authMiddleware(), LikeJoke)
	}
	// Start the app
	router.Run(":80")
}
