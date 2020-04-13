"use strict";
import ThetaApi from './theta.api';
import Games from '../games';

export default class BabbleCMD {
    static modCmd(msg, usr, channel) {
        msg = msg.toLowerCase().substr(1).split(" ");
        switch (true) {
            case msg[0] == "hello" || msg[0] == "hi":
                ThetaApi.sendMsg("hello", channel);
                break;
            case msg[0] == "num" || msg[0] == "number" || msg[0] == "ng":
                Games.startNumberGame(msg, channel);
                break;
            case msg[0] == "uptime":
                ThetaApi.getUpTime(channel);
                break;
            case msg[0] == "streamkey":
                ThetaApi.sendMsg("Want a Theta StreamKey; This is how: https://community.theta.tv/stream-keys/", channel);
                break;
            case msg[0] == "patreon":
                ThetaApi.sendMsg("Feeling Supportive; Love BABBLE; Please be a Great Freind and Visit my PATREON: https://www.patreon.com/babblechatbot?fan_landing=true", channel);
                break;
            case msg[0] == "babble" || msg[0] == "support" || msg[0] == "info":
                ThetaApi.sendMsg("Babble Support Discord: https://www.discord.gg/73gusq7", channel);
                break;
            case msg[0] == "magic8":
                Games.play8Ball(usr, channel);
                break;

        }
    }

    static runCmd(msg, usr, channel) {
        msg = msg.toLowerCase().substr(1).split(" ");
        switch (true) {
            case msg[0] == "hello" || msg[0] == "hi":
                ThetaApi.sendMsg("hello", channel);
                break;
            case msg[0] == "num" || msg[0] == "number" || msg[0] == "ng":
                Games.startNumberGame(msg, channel);
                break;
            case msg[0] == "uptime":
                ThetaApi.getUpTime(channel);
                break;
            case msg[0] == "streamkey":
                ThetaApi.sendMsg("Want a Theta StreamKey; This is how: https://community.theta.tv/stream-keys/", channel);
                break;
            case msg[0] == "patreon":
                ThetaApi.sendMsg("Feeling Supportive; Love BABBLE; Please be a Great Freind and Visit my PATREON: https://www.patreon.com/babblechatbot?fan_landing=true", channel);
                break;
            case msg[0] == "babble" || msg[0] == "support" || msg[0] == "info":
                ThetaApi.sendMsg("Babble Support Discord: https://www.discord.gg/73gusq7", channel);
                break;
            case msg[0] == "magic8":
                Games.play8Ball(usr, channel);
                break;
        }
    }

    static checkViewHooks(msg, usr, channel) {
        msg = msg.toLowerCase().substr(1).split(" ");
        switch (true) {
            case msg[0] == "magic8":
                Games.play8Ball(usr, channel);
                break;
            case msg[0] == "streamkey":
                ThetaApi.sendMsg("Want a Theta StreamKey; This is how: https://community.theta.tv/stream-keys/", channel);
                break;
            case msg[0] == "patreon":
                ThetaApi.sendMsg("Feeling Supportive; Love BABBLE; Please be a Great Freind and Visit my PATREON: https://www.patreon.com/babblechatbot?fan_landing=true", channel);
                break;
        }
    }

    static statusHandler(msg, channel) {
        let msgText = msg.data.text;
        let msgType = msg.type;
        let user = msg.data.user;
        let channelConfig = globalThis.channels[channel];
        switch (true) {
            case msgType == "hello_message":
                ThetaApi.sendMsg("Hello @" + user.username + " thanks for coming by, if you like this channel please follow!", channel);
                break;
            case msgType == "donation":
                ThetaApi.sendMsg("Thank you for the " + msg.data.tfuel + " :tfuel: !! @" + msg.data.sender.username, channel);
                break;
            case msgType == "follow":
                ThetaApi.sendMsg("Thanks for the Follow !! Welcome @" + user.username, channel);
                break;
            case msgType == "gift_item":
                ThetaApi.sendMsg("Enjoy your Gift!! @" + msg.data.recipient.username, channel);
                break;
            case msgType == "subscribe":
                ThetaApi.sendMsg("Thanks for the Sub and Support! @" + user.username, channel);
                break;
            case msgType == "gift_subscribe":
                ThetaApi.sendMsg("Thank you @" + msg.data.sender.username + "for gifting @" + msg.data.recipient.username + msg.data.subscribe, channel);
                break;
            case msgType == "level_up":
                ThetaApi.sendMsg("Lets GO @" + user.username + "you just reached level" + msg.data.xp + "GG's in chat everyone", channel);
                break;
        }
    }
}