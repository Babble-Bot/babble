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
	userID := c.Param("userId")
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
		if channelsDB.Channels[i].UserID == userID {
			channelsDB.Channels[i].AccessToken = "xxxxxxxxxxxx"
			c.JSON(http.StatusOK, gin.H{
				"status": http.StatusOK,
				"body": channelsDB.Channels[i],
			})
		}
	}
}

func FindNumberGameConfig(c *gin.Context) {
	channelID := c.Param("channelId")
	db, err := os.Open("./db/theta/activeNumberGames.json")
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
	var numberGameDB models.NumberGameDB
	json.Unmarshal(byteValue, &numberGameDB)
	for i := 0; i < len(numberGameDB.Channels); i++ {
		if numberGameDB.Channels[i].ChannelId == channelID {
			c.JSON(http.StatusOK, gin.H{
				"status": http.StatusOK,
				"body": numberGameDB.Channels[i],
			})
		}
	}
}

func UpdateChannel(c *gin.Context) {
	db, err := os.Open("./db/theta/channels.json")
	if err != nil {
		fmt.Println(err)
		c.JSON(http.StatusNotFound, gin.H{
			"status": http.StatusNotFound,
			"Error":  "Not Found",
		})
	}
	fmt.Println("Successfully Opened channels.json")
	defer db.Close()
	userID := c.Param("userId")
	reqBody, err := ioutil.ReadAll(c.Request.Body)
	byteValue, _ := ioutil.ReadAll(db)
	var channelsDB models.ChannelsDB
	var channelReq models.Channels
	json.Unmarshal(byteValue, &channelsDB)
	json.Unmarshal(reqBody, &channelReq)
	for i := 0; i < len(channelsDB.Channels); i++ {
		if channelsDB.Channels[i].UserID == userID {
			channelsDB.Channels[i] = channelReq
			updatedDb, _ := json.MarshalIndent(channelsDB, "", " ")
			ioutil.WriteFile("./db/theta/channels.json", updatedDb, 0644)
			channelsDB.Channels[i].AccessToken = "xxxxxxxxxxxx"
			c.JSON(http.StatusOK, gin.H{
				"status": http.StatusOK,
				"body":   channelsDB.Channels[i],
			})
		}
	}
}

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
