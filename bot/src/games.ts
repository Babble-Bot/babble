"use strict";

import ThetaApi from './theta.api';

export default class Games {
    /**
     * Number Game Init
     */
    static startNumberGame(msg, channel) {
        let ngChannelConfig = globalThis.activeNumberGames[channel];
        let maxInt = Math.floor(Math.random() * 100) + 1; //Default of 100
        if (msg[1] == "kill") {
            ngChannelConfig = {numberGame: false, number: 0, players: {}};
            ThetaApi.sendMsg("The Number Game has been cancelled :burnttoast:", channel);
        } else {
            if (msg[1]) {
                maxInt = msg[1];
            }
            if (maxInt < 25) {
                maxInt = 25;
            }
            if (!ngChannelConfig.numberGame) {
                ThetaApi.sendMsg("Number Game Started :toastgrin: pick a number between 1 and " + maxInt, channel);
                ngChannelConfig.numberGame = true;
                ngChannelConfig.number = Math.floor(Math.random() * maxInt) + 1;
            }else{
                ThetaApi.sendMsg("Number Game already active", channel);
            }
        }

    }

    /**
     * Number Game Manager
     */
    static numGameManager(msg, usr, channel) {
        let guess = parseInt(msg);
        let ngChannelConfig = globalThis.activeNumberGames[channel];
        // let ngPlayer = ngChannelConfig[usr.id];

        // if(!ngPlayer.lastGuess){
        //     ngPlayer.lastGuess = guess;
        // }

        // if(guess == ngPlayer.lastGuess + 1 || guess == ngPlayer.lastGuess - 1){
        //     ThetaApi.sendMsg("@" + usr.username + " Sorry but you guess's can not be consecutive ie. 1 2 3 or 3 2 1", channel);
        // }else{
        //     ngPlayer.lastGuess = guess;
        // }

        if (guess == ngChannelConfig.number) {
            ThetaApi.sendMsg("Congrats !! @" + usr.username + " Your the winner with: " + ngChannelConfig.number + ":flex:", channel);
            ngChannelConfig.number = 0;
            ngChannelConfig.numberGame = false;
            //TODO: setup anti spam
            //TODO: auto send gift able item ?
            //TODO: set up limmit trys
        }
    }

    /**
     * Magic 8 Ball
     */
    static play8Ball(usr, channel) {
        let responses = [
            'It is certain',
            'It is decidedly so',
            'Without a doubt',
            'Yes definitely',
            'You may rely on it',
            'As I see it, yes',
            'Most likely',
            'Outlook good',
            'yes',
            'Signs point to yes',
            'Reply hazy try again',
            'Ask again later',
            'Better not tell you now',
            'Cannot predict now',
            'Concentrate and ask again',
            'Do not count on it',
            'My reply is no',
            'My sources say no',
            'Outlook not so good',
            'Very doubtful',
        ];
        let choice = responses[Math.floor(Math.random() * responses.length)];
        let msg = "@" + usr.username + " " + choice;
        ThetaApi.sendMsg(msg, channel);
    }
}