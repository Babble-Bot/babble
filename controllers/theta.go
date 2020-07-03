package controllers

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"

	"github.com/Babble-Bot/babble/models"
	"github.com/gin-gonic/gin"
)

func FindChannel(c *gin.Context) {
	userId := c.Param("userId")
	db, err := os.Open("./db/theta/channels.json")
	if err != nil {
		fmt.Println(err)
		c.JSON(http.StatusNotFound, gin.H{
			"status": http.StatusNotFound,
			"Error":  "Not Found",
		})
	}
	//fmt.Println("Successfully Opened channels.json")
	defer db.Close()
	byteValue, _ := ioutil.ReadAll(db)
	var channelsDB models.ChannelsDB
	json.Unmarshal(byteValue, &channelsDB)
	for i := 0; i < len(channelsDB.Channels); i++ {
		if channelsDB.Channels[i].UserID == userId {
			channelsDB.Channels[i].AccessToken = "xxxxxxxxxxxx"
			c.JSON(http.StatusOK, gin.H{
				"status": http.StatusOK,
				"body":   channelsDB.Channels[i],
			})
		}
	}
}

// func UpdateChannel(c *gin.Context) {
// 	userId := c.Param("userId")
// 	reqBody, err := ioutil.ReadAll(c.Request.Body)
// 	db, err := os.Open("./db/theta/channels.json")
// 	if err != nil {
// 		fmt.Println(err)
// 		c.JSON(http.StatusNotFound, gin.H{
// 			"status": http.StatusNotFound,
// 			"Error":  "Not Found",
// 		})
// 	}
// 	//fmt.Println("Successfully Opened channels.json")
// 	defer db.Close()
// 	byteValue, _ := ioutil.ReadAll(db)
// 	var channelsDB models.ChannelsDB
// 	json.Unmarshal(byteValue, &channelsDB)
// 	json.Unmarshal(reqBody, &reqBody)
// 	for i := 0; i < len(channelsDB.Channels); i++ {
// 		if channelsDB.Channels[i].UserID == userId {
// 			c.JSON(http.StatusOK, gin.H{
// 				"status": http.StatusOK,
// 				"body":   channelsDB.Channels[i],
// 			})
// 		}
// 	}
// }

func GetInstalls(c *gin.Context) {
	db, err := os.Open("./db/theta/channels.json")
	if err != nil {
		fmt.Println(err)
		c.JSON(http.StatusNotFound, gin.H{
			"status": http.StatusNotFound,
			"Error":  "Not Found",
		})
	}
	//fmt.Println("Successfully Opened channels.json")
	defer db.Close()
	byteValue, _ := ioutil.ReadAll(db)
	var channelsDB models.ChannelsDB
	json.Unmarshal(byteValue, &channelsDB)
	installs := models.Installs{Theta: len(channelsDB.Channels), Twitch: 0}
	c.JSON(http.StatusOK, gin.H{
		"status": http.StatusOK,
		"body":   installs,
	})
}
