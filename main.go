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
		api.GET("/number-games/:channelId", controllers.FindNumberGameConfig)
		api.GET("/installs", controllers.GetInstalls)
		api.POST("/channel/:userId", controllers.UpdateChannel)
	}
	// Start the app
	router.Run(":80")
}
