package thetaModel

type channelsDB struct {
	channels []channel
}

type channel struct {
	clientID    string
	userID      string
	accessToken string
	prefix      string
	botName     string
	alertConfig struct {
		all       bool
		hello     bool
		donation  bool
		follow    bool
		gift      bool
		sub       bool
		giftedsub bool
		level     bool
		quiz      bool
		raffle    bool
		rafflewin bool
	}
	socialLinks struct {
		twitter string
		twitch  string
		youtube string
		discord string
	}
}
