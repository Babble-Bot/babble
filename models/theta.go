package models

type ChannelsDB struct {
	Channels []struct {
		ClientID    string `json:"clientId"`
		UserID      string `json:"userId"`
		AccessToken string `json:"accessToken"`
		Prefix      string `json:"prefix"`
		AlertConfig struct {
			All       bool `json:"all"`
			Hello     bool `json:"hello"`
			Donation  bool `json:"donation"`
			Follow    bool `json:"follow"`
			Gift      bool `json:"gift"`
			Sub       bool `json:"sub"`
			Giftedsub bool `json:"giftedsub"`
			Level     bool `json:"level"`
			Quiz      bool `json:"quiz"`
			Raffle    bool `json:"raffle"`
			Rafflewin bool `json:"rafflewin"`
		} `json:"alertConfig"`
		SocialLinks struct {
			Twitter string `json:"twitter"`
			Twitch  string `json:"twitch"`
			Youtube string `json:"youtube"`
			Discord string `json:"discord"`
		} `json:"socialLinks"`
	} `json:"channels"`
}

type Installs struct {
	Theta  int `json:theta`
	Twitch int `json:twitch`
}
