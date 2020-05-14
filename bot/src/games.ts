"use strict";

import ThetaApi from './utils/theta.api';
import BabbleAip from './utils/babble.api';
import Helpers from './utils/helpers';

export default class Games {
    /**
     * Number Game Init
     */
    static startNumberGame(msg, channel) {
        let ngChannelConfig = BabbleAip.getNumGameConfig(channel);
        let maxInt: number = Math.floor(Math.random() * 100) + 1; //Default of 100
        switch(msg[1]){
            case "kill":
                ngChannelConfig = {channelId:channel, active: false, winningNumber: 0, players: {}, lastGame: ngChannelConfig.lastGame};
                ThetaApi.sendMsg("The Number Game has been cancelled :burnttoast:", channel);
                break;
            case "repeat":
                ngChannelConfig.winningNumber = Math.floor(Math.random() * ngChannelConfig.lastGame.maxInt) + 1;
                ThetaApi.sendMsg("Number Game Started :toastgrin: pick a number between 1 and " + ngChannelConfig.lastGame.maxInt, channel);
                break;
            default:
                if (msg[1]) {
                    maxInt = parseInt(msg[1]);
                }
                if (maxInt < 25) {
                    maxInt = 25;
                }
                if (!ngChannelConfig.active) {
                    ngChannelConfig.active = true;
                    ngChannelConfig.winningNumber = Math.floor(Math.random() * maxInt) + 1;
                    ngChannelConfig.lastGame = {maxInt: maxInt};
                    ThetaApi.sendMsg("Number Game Started :toastgrin: pick a number between 1 and " + maxInt, channel);
                }else{
                    ThetaApi.sendMsg("Number Game already active", channel);
                }
                break;
        }
    }

    /**
     * Number Game Manager
     */
    static numGameManager(msg, usr, channel) {
        //TODO: auto send gift able item ?
        //TODO: set up limmit trys
        let guess: number = parseInt(msg);
        let ngChannelConfig = BabbleAip.getNumGameConfig(channel);
        let ngPlayer =  ((ngChannelConfig.players[usr.id]) ? ngChannelConfig.players[usr.id] : ngChannelConfig.players[usr.id] = {
            userId: usr.id,
            lastTry: guess,
            tres: []
        });
        ngPlayer.tres.push(guess);
        if(guess == (ngPlayer.lastTry + 1) || guess == (ngPlayer.lastTry - 1)){
            ThetaApi.sendMsg("@" + usr.username + " Sorry but you guess's can not be consecutive ie. 1 2 3 or 3 2 1", channel);
        }else{
            ngPlayer.lastTry = guess;
        }
        if (guess == ngChannelConfig.winningNumber) {
            ThetaApi.sendMsg("Congrats !! @" + usr.username + " Your the winner with: " + ngChannelConfig.winningNumber + ":flex:", channel);
            ngChannelConfig.winningNumber = 0;
            ngChannelConfig.active = false;
            ngChannelConfig.players = {};
        }
    }

    /**
     * Magic 8 Ball
     */
    static play8Ball(msg, usr, channel) {
        Helpers.removeItemOnce(msg, "!");
        Helpers.removeItemOnce(msg, "magic8");
        Helpers.removeItemOnce(msg, "?");
        msg = msg.toString();
        msg = msg.replace(",", " ");
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
        let message = "@" + usr.username + " asked: " + msg + "? Magic 8 Ball: " + choice;
        ThetaApi.sendMsg(message, channel);
    }
}
