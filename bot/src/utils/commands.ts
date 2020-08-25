"use strict";
import * as channelDb from '../../../db/theta/channels.json';
import ThetaApi from './theta.api';
import BabbleAip from './babble.api';
import Games from '../games';
import { config } from 'chai';
import Helpers from './helpers';

const babbleCmds = ["name", "prefix", "hello", "hi", "num", "number", "ng", "uptime", "alert", "streamkey", "patreon", "babble", "info", "help", "support", "magic8", "twitter", "twitch", "youtube", "discord", "twitchbridge", "addcmd", "rmcmd", "timedmsg"];
export default class BabbleCMD {

    static runCmd(msg, usr, channel) {
        msg = msg.substr(1).split(" ");
        msg[0] = msg[0].toLowerCase();
        const channelConfig = BabbleAip.getChannelConfig(channel);
        let isCustomCmd;
        let customCmdIndx;
        channelConfig.customCmds.forEach((cmd, index) => {
            if(msg[0] == cmd.name){
                isCustomCmd = true;
                customCmdIndx = index;
            }
        });
        switch (true) {
            case msg[0] == "name":
                BabbleAip.updateBotName(msg, channel);
                break;
            case msg[0] == "prefix":
                BabbleAip.updatePrefix(msg, channel);
                break;
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
                this.alertConfigHandler(msg, channel);
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
                Games.play8Ball(msg, usr, channel);
                break;
            case msg[0] == "twitter" || msg[0] == "twitch" || msg[0] == "youtube" || msg[0] == "discord":
                this.SocialLinkHandler(msg, channel);
                break;
            case msg[0] == "twitchbridge":
                this.bridgeConfigHandler(msg, channel);
                break;
            case msg[0] == "addcmd":
                this.addCustomCmd(msg, channel);
                break;
            case msg[0] == "rmcmd":
                this.removeCustomCmd(msg, channel);
                break;
            case isCustomCmd :
                this.runCustomCmd(customCmdIndx, channel);
                break;
            // case msg[0] == "timedmsg":
            //     ThetaApi.timedMsg(msg, channel);
            //     break;
        }
    }


    static checkViewHooks(msg, usr, channel) {
        msg = msg.toLowerCase().substr(1).split(" ");
        switch (true) {
            case msg[0] == "magic8":
                Games.play8Ball(msg, usr, channel);
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
        }
    }

    static statusHandler(msg, channel) {
        let msgText = msg.data.text;
        let msgType = msg.type;
        let user = msg.data.user;
        let channelConfig = BabbleAip.getChannelConfig(channel);
        switch (true) {
            case (msgType == "hello_message" && channelConfig.alertConfig.hello):
                ThetaApi.sendMsg("Hello @" + user.username + " thanks for coming by, if you like this channel please follow!", channel);
                break;
            case (msgType == "donation" && channelConfig.alertConfig.donation):
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
            case (msgType == "quiz" && channelConfig.alertConfig.quiz):
                ThetaApi.sendMsg('@' + user.username + ' Has started a new Quiz "' + msg.data.quiz.text + '" Good Luck all!', channel);
                break;
            case (msgType == "raffle" && channelConfig.alertConfig.raffle):
                //console.log(msg.data.raffle.prizes);
                ThetaApi.sendMsg('@' + user.username + ' Has started a new Raffle "' + msg.data.raffle.text + '" Good Luck all!', channel);
                break;
            case (msgType == "raffle_winner" && channelConfig.alertConfig.rafflewin):
                ThetaApi.sendMsg("@" + user.username + " congrats on winning " + msg.data.item.name + " GG's in chat everyone", channel);
                break;
            case msgType == "system_chat_message":
                if (msgText.includes("has raided the stream")) {
                    ThetaApi.sendMsg("RAID HYPE!! :nominal: :nominal: @" + user.username + "went crazy :crazy: Spam Raid in chat everyone!!", channel);
                }
                break;
        }
    }

    static alertConfigHandler(msg, channel) {
        const channelConfig = BabbleAip.getChannelConfig(channel);
        const types = ["all", "hello", "donation", "follow", "gift", "sub", "giftedsub", "level", "quiz", "raffle", "rafflewin"];
        const type = msg[1];
        const conf = msg[2];
        if (types.indexOf(type) > -1) {
            if (conf == "on" || conf == "true") {
                channelConfig.alertConfig[type] = true;
                ThetaApi.sendMsg("Your Alert Config for " + type + " is now set to " + conf, channel);
            } else if (conf == "off" || conf == "false") {
                channelConfig.alertConfig[type] = false;
                ThetaApi.sendMsg("Your Alert Config for " + type + " is now set to " + conf, channel);
            } else {
                ThetaApi.sendMsg("Sorry but I did not recognize your Config option you can use [on, true, off, false]", channel);
            }
        } else {
            ThetaApi.sendMsg("Sorry but I did not recognize the Type of alert you would like to change you can use [all, hello, donation, follow, gift, sub, giftedsub, level, quiz, raffle, rafflewin]", channel);
        }
    }

    static bridgeConfigHandler(msg, channel) {
        const channelConfig = BabbleAip.getChannelConfig(channel);
        if(msg.length > 2){
            const type = msg[1];
            const conf = msg[2];
            if(type == "channelId"){
                BabbleAip.updateBridgeConfig('twitchConfig', "channelId", conf, channel);
            }else{
                ThetaApi.sendMsg("Sorry that config is not found. Run !help for help", channel);
            }
        }else {
            const conf = msg[1];
            if(channelConfig.bridgeConfig.twitchConfig.channelId != ""){
                ThetaApi.sendMsg("Please run !twitchbridge channelId <your channel Id> first.", channel);
            }else{
                BabbleAip.updateBridgeConfig('twitchConfig', "active", conf, channel);
            }
        }
    }

    static SocialLinkHandler(msg: any, channel: any) {
        const channelConfig = BabbleAip.getChannelConfig(channel);
        switch (true) {
            case msg[0] == "twitter" && (channelConfig.socialLinks.twitter != ''):
                ThetaApi.sendMsg(`Hey follow me on Twitter ${channelConfig.socialLinks.twitter}`, channel);
                break;
            case msg[0] == "twitch" && (channelConfig.socialLinks.twitch != ''):
                ThetaApi.sendMsg(`Hey you can also watch me on Twitch ${channelConfig.socialLinks.twitch}`, channel);
                break;
            case msg[0] == "youtube" && (channelConfig.socialLinks.youtube != ''):
                ThetaApi.sendMsg(`Hey follow me on YouTube at ${channelConfig.socialLinks.youtube}`, channel);
                break;
            case msg[0] == "discord" && (channelConfig.socialLinks.discord != ''):
                ThetaApi.sendMsg(`Hey join me on Discord ${channelConfig.socialLinks.discord}`, channel);
                break;
        }
    }

    static addCustomCmd(msg, channel){
        const channelConfig = BabbleAip.getChannelConfig(channel);
        let newCmdName = msg[1];
        let cmdsList = [];
        Helpers.removeItemOnce(msg, "!");
        Helpers.removeItemOnce(msg, "addcmd");
        Helpers.removeItemOnce(msg, newCmdName.toString());
        msg = msg.toString().split(",").join(" ");
        channelConfig.customCmds.forEach((cmd) => {
            cmdsList.push(cmd.name);
        });
        switch(true){
            case babbleCmds.includes(newCmdName):
                ThetaApi.sendMsg("Sorry command name is reserved.", channel);
                break;
            case cmdsList.includes(newCmdName):
                ThetaApi.sendMsg("You have already added a command with the same name.",channel);
                break;
            default:
                let newCmd = {
                    name: newCmdName,
                    message: msg
                };
                channelConfig.customCmds.push(newCmd);
                BabbleAip.updateChannelConfig(channelConfig, channel);
                ThetaApi.sendMsg("Your new command can be used by typing '" + channelConfig.prefix + newCmdName + "' and I will respond with '" + msg + "' when ever your new command is used" , channel);
                break;
        }
    }

    static removeCustomCmd(msg,  channel){
        const cmdToRemove = msg[1];
        const channelConfig = BabbleAip.getChannelConfig(channel);
        let cmdsList = [];
        let cmdIndex;
        channelConfig.customCmds.forEach((cmd, index) => {
            cmdsList.push(cmd.name);
            if(cmd.name == cmdToRemove){
                cmdIndex = index;
            }
        });
        switch(true){
            case babbleCmds.includes(cmdToRemove):
                ThetaApi.sendMsg("Sorry command name is reserved.", channel);
                break;
            case !cmdsList.includes(cmdToRemove):
                ThetaApi.sendMsg("Sorry command not found.",channel);
                break;
            case cmdsList.includes(cmdToRemove):
                if (cmdIndex > -1) {
                    channelConfig.customCmds.splice(cmdIndex, 1);
                    BabbleAip.updateChannelConfig(channelConfig, channel);
                    ThetaApi.sendMsg(cmdToRemove + " has been removed." , channel);
                }
                break;
        }
    }

    static runCustomCmd(customCmdIndx: any, channel: any) {
        const channelConfig = BabbleAip.getChannelConfig(channel);
        let msg = channelConfig.customCmds[customCmdIndx].message;
        ThetaApi.sendMsg(msg, channel);
    }
}
