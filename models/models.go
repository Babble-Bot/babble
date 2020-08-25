package models

type ChannelsDB struct {
	Channels []Channels `json:"channels"`
}

type NumberGameDB struct {
	Channels []NumberGameConfig `json:channels`
}

type Channels struct {
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
	} 				   `json:"alertConfig"`
	SocialLinks struct {
		Twitter string `json:"twitter"`
		Twitch  string `json:"twitch"`
		Youtube string `json:"youtube"`
		Discord string `json:"discord"`
	} 				   `json:"socialLinks"`
	BridgeConfig struct{
		ThetaConfig struct{
			Active string		`json:"active"`
			ChannelId string 	`json:"channelId"`
		}						`json:"thetaConfig"`
		TwitchConfig struct{
			Active string		`json:"active"`
			ChannelId string 	`json:"channelId"`
		}						`json:"twitchConfig"`
	}							`json:"bridgeConfig"`
	CustomCmds []Cmd			`json:"customCmds"`
}

type Cmd struct {
	Name string					`json:"name"`
	Message string 				`json:"message"`
}

type NumberGameConfig struct {
	ChannelId   	string 			`json:"channelId"`
	Active			bool 			`json:"active"`
	WinningNumber	int 			`json:"winningNumber"`
	Players			[]NGPlayers 	`json:"players"`
	LastGame 		struct{
		MaxInt		int				`json:"maxInt"`
	} 								`json:"lastGame"`
}

type NGPlayers struct {
	UserId	string	`json:"userId"`
	LastTry	string	`json:"lastTry"`
	Tres	[]int	`json"tres"`
}

type Installs struct {
	Theta  int `json:"theta"`
	Twitch int `json:"twitch"`
}