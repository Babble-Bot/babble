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
	var channelsDB models.channelsDB
	json.Unmarshal(byteValue, &channelsDB)
	for i := 0; i < len(channelsDB.channels); i++ {
		if channelsDB.channels[i].userID == userId {
			channelsDB.channels[i].accessToken = "xxxxxxxxxxxx"
			c.JSON(http.StatusOK, gin.H{
				"status": http.StatusOK,
				"body":   channelsDB.channels[i],
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
	userId := c.Param("userId")
	reqBody, err := ioutil.ReadAll(c.Request.Body)
	byteValue, _ := ioutil.ReadAll(db)
	var channelsDB models.channelsDB
	var channelReq models.channel
	json.Unmarshal(byteValue, &channelsDB)
	json.Unmarshal(reqBody, &channelReq)
	for i := 0; i < len(channelsDB.channels); i++ {
		if channelsDB.channels[i].UserID == userId {
			channelsDB.channels[i] = channelReq
			updatedDb, _ := json.Marshal(channelsDB)
			ioutil.WriteFile("./db/theta/channels.json", updatedDb, 0644)
			c.JSON(http.StatusOK, gin.H{
				"status": http.StatusOK,
				"body":   channelsDB.channels[i],
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
	var channelsDB models.channelsDB
	json.Unmarshal(byteValue, &channelsDB)
	installs := models.installs{theta: len(channelsDB.channels), twitch: 0}
	c.JSON(http.StatusOK, gin.H{
		"status": http.StatusOK,
		"body":   installs,
	})
}
