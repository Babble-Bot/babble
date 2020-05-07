
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

interface Install {
    client_id: string;
    user_id: string;
    access_token: string;
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

interface LastGame { maxInt: number; }
interface Players { [index: string]: Player }
interface Channels { [index: string]: Channel; }
interface ActiveNumberGames { [index: string]: NumberGame; }
interface Installs extends Array<Install> { }

var defaultPrefix: string = "!";
var subscribers: string[] = [];
var channels: Channels;
var activeNumberGames: ActiveNumberGames;