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
			c.JSON(http.StatusOK, gin.H{
				"status": http.StatusOK,
				"body":   channelsDB.Channels[i],
			})
		}
	}
}

func Installs(c *gin.Context) {
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
	c.JSON(http.StatusOK, gin.H{
		"status":        http.StatusOK,
		"numOfInstalls": len(channelsDB.Channels),
	})
}
