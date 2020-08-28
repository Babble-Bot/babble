
interface Player {
    userId: string,
    lastTry: number,
    tres: number[];
}

interface Channel {
    clientId: string;
    userId: string;
    accessToken: string;
    prefix: string;
    botName: string;
    alertConfig: AlertConfig;
    socialLinks: SocialLinks;
    bridgeConfig: BridgeConfig;
    customCmds: Cmd[];
}

interface NumberGame {
    channelId: string;
    active: boolean;
    winningNumber: number,
    players: Player[],
    lastGame: LastGame;
}

interface AlertConfig{
    all: boolean;
    hello: boolean;
    donation: boolean;
    follow: boolean;
    gift: boolean;
    sub: boolean;
    giftedsub: boolean;
    level: boolean;
    quiz: boolean;
    raffle: boolean;
    rafflewin: boolean;
}

interface BridgeConfig{
    thetaConfig: ThetaConfig;
    twitchConfig: TwitchConfig;
}
interface TwitchConfig{
    active: boolean,
    channelId: string,
}

interface ThetaConfig{
    active: boolean,
    channelId: string,
}

interface SocialLinks{
    twitter: string;
    twitch: string;
    youtube: string;
    discord: string;
    instagram: string;
    facebook: string;
    snapchat: string;
    tiktok: string
}

interface Cmd {
    name: string,
    message: string
}

interface TimedMessage{
    interval: number,
    message: string
}

interface LastGame { maxInt: number; }
interface TimedMessages { [index: number]: TimedMessages; }
interface Players { [index: string]: Player }
interface Channels { [index: string]: Channel; }
interface ActiveNumberGames { [index: string]: NumberGame; }

var defaultPrefix: string = "!";
var subscribers: string[] = [];
var channels: Channels;
var activeNumberGames: ActiveNumberGames;