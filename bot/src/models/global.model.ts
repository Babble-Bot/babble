
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
    showStatus?: boolean;
}

interface NumberGame {
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

interface LastGame { maxInt: number; }
interface Players { [index: string]: Player }
interface Channels { [index: string]: Channel; }
interface ActiveNumberGames { [index: string]: NumberGame; }
interface Installs extends Array<Install> { }

var defaultPrefix: string = "!";
var subscribers: string[] = [];
var channels: Channels = {};
var activeNumberGames: ActiveNumberGames;