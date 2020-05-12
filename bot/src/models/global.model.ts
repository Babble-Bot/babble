
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
}

interface NumberGame {
    channelId: string;
    active: boolean;
    winningNumber: number,
    players: Players,
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

interface TimedMessage{
    interval: number,
    message: string
}

interface LastGame { maxInt: number | string; }
interface TimedMessages { [index: number]: TimedMessages; }
interface Players { [index: string]: Player }
interface Channels { [index: string]: Channel; }
interface ActiveNumberGames { [index: string]: NumberGame; }

var defaultPrefix: string = "!";
var subscribers: string[] = [];
var channels: Channels;
var activeNumberGames: ActiveNumberGames;