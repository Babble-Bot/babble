package models

type ChannelsDB struct {
	Channels []Channel `json:"channels"`
}

type Channel struct {
	ClientID    string `json:"clientId"`
	UserID      string `json:"userId"`
	AccessToken string `json:"accessToken"`
	Prefix      string `json:"prefix"`
	BotName     string `json:"botName"`
	AlertConfig struct {
		All       bool `json:"all"`
		Hello     bool `json:"hello"`
		Donation  bool `json:"donation"`
		Follow    bool `json:"follow"`
		Gift      bool `json:"gift"`
		Sub       bool `json:"sub"`
		GiftedSub bool `json:"giftedsub"`
		Level     bool `json:"level"`
		Quiz      bool `json:"quiz"`
		Raffle    bool `json:"raffle"`
		RaffleWin bool `json:"rafflewin"`
	} `json:"alertConfig"`
	SocialLinks struct {
		Twitter string `json:"twitter"`
		Twitch  string `json:"twitch"`
		Youtube string `json:"youtube"`
		Discord string `json:"discord"`
	} `json:"socialLinks"`
}

type Installs struct {
	Theta  int `json:"theta"`
	Twitch int `json:"twitch"`
}