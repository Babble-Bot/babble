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
            case msg[0] == "alert":
                this.alertConfigManager(msg, channel);
                break;
            case msg[0] == "streamkey":
                ThetaApi.sendMsg("Want a Theta StreamKey; This is how: https://community.theta.tv/stream-keys/", channel);
                break;
            case msg[0] == "patreon":
                ThetaApi.sendMsg("Feeling Supportive; Love BABBLE; Please be a Great Freind and Visit my PATREON: https://www.patreon.com/babblechatbot?fan_landing=true", channel);
                break;
            case msg[0] == "babble" || msg[0] == "support" || msg[0] == "info" || msg[0] == "help":
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
            case msg[0] == "alert":
                this.alertConfigManager(msg, channel);
                break;
            case msg[0] == "streamkey":
                ThetaApi.sendMsg("Want a Theta StreamKey; This is how: https://community.theta.tv/stream-keys/", channel);
                break;
            case msg[0] == "patreon":
                ThetaApi.sendMsg("Feeling Supportive; Love BABBLE; Please be a Great Freind and Visit my PATREON: https://www.patreon.com/babblechatbot?fan_landing=true", channel);
                break;
            case msg[0] == "babble" || msg[0] == "support" || msg[0] == "info" || msg[0] == "help":
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
            case (msgType == "hello_message" && channelConfig.alertConfig.hello):
                ThetaApi.sendMsg("Hello @" + user.username + " thanks for coming by, if you like this channel please follow!", channel);
                break;
            case (msgType == "donation"  && channelConfig.alertConfig.donation):
                ThetaApi.sendMsg("Thank you for the " + msg.data.tfuel + " :tfuel: !! @" + msg.data.sender.username, channel);
                break;
            case (msgType == "follow" && channelConfig.alertConfig.follow):
                ThetaApi.sendMsg("Thanks for the Follow !! Welcome @" + user.username, channel);
                break;
            case (msgType == "gift_item" && channelConfig.alertConfig.gift):
                ThetaApi.sendMsg("Enjoy your Gift!! @" + msg.data.recipient.username, channel);
                break;
            case (msgType == "subscribe" && channelConfig.alertConfig.sub):
                ThetaApi.sendMsg("Thanks for the Sub and Support! @" + user.username, channel);
                break;
            case (msgType == "gift_subscribe" && channelConfig.alertConfig.giftedsub):
                ThetaApi.sendMsg("Thank you @" + msg.data.sender.username + " for gifting @" + msg.data.recipient.username + msg.data.subscribe + " a Sub", channel);
                break;
            case (msgType == "level_up" && channelConfig.alertConfig.level):
                ThetaApi.sendMsg("Lets GO @" + user.username + " you just reached level " + user.channel_xp.level + " GG's in chat everyone", channel);
                break;
        }
    }

    static alertConfigManager(msg, channel) {
        const channelConfig = globalThis.channels[channel];
        const types = ["all", "hello", "donation", "follow", "gift", "sub", "giftedsub", "level"];
        const type = msg[1];
        const conf = msg[2];
        if(types.indexOf(type) > -1){
            if(conf == "on" || conf == "true"){
                channelConfig.alertConfig[type] = true;
                ThetaApi.sendMsg("Your Alert Config for " + type + " is now set to " + conf, channel);
            }else if(conf == "off" || conf == "false"){
                channelConfig.alertConfig[type] = false;
                ThetaApi.sendMsg("Your Alert Config for " + type + " is now set to " + conf, channel);
            }else{
                ThetaApi.sendMsg("Sorry but I did not recognize your Config option you can use [on, true, off, false]",channel);
            }
        }else{
            ThetaApi.sendMsg("Sorry but I did not recognize the Type of alert you would like to change you can use [all, hello, donation, follow, gift, sub, giftedsub, level]",channel);
        }
    }
}
