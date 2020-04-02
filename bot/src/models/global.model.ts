
interface Player{
    userId: string,
    lastGuess: string,
    tres: string[]
}

interface Channel {
    clientId: string;
    userId: string;
    accessToken: string;
    prefix: string;
    showStatus?: boolean;
}

interface NumberGame {
    numberGame: boolean;
    number: number,
    players: object
}

interface Channels {
    [index: string]: Channel
}

interface ActiveNumberGames{
    [index: string]: NumberGame
}

interface Install {
    client_id: string;
    user_id: string;
    access_token: string;
}

interface Installs extends Array<Install>{
}

var defaultPrefix: string = "!";
var subscribers: string[] = [];
var channels: Channels = {};
var activeNumberGames: ActiveNumberGames;