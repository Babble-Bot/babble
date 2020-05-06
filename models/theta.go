package models

type Channels struct {
	channel struct {
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
	} `json:"channel"`
}
