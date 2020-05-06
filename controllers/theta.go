package controllers

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"

	"github.com/Babble-Bot/babble/models"
	"github.com/gin-gonic/gin"
)

func FindChannel(c *gin.Context) {
	db, err := os.Open("../db/theta/channels.json")
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println("Successfully Opened channels.json")
	defer db.Close()
	byteValue, _ := ioutil.ReadAll(db)
	var channel models.Channel
	json.Unmarshal(byteValue, &channel)
	for i := 0; i < len(channel); i++ {
		fmt.Println("Channel key: " + channel[i])

	}

	//c.JSON(http.StatusOK, gin.H{"data": })
}
