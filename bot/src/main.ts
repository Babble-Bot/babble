"use strict";
import PubNub = require('pubnub');
import * as appConfig from './config.json';
import ThetaApi from './theta.api';
import BabbleAip from './babble.api';
import Games from './games';


class Babble{
    pubnub: any = new PubNub({ subscribeKey: appConfig.subscribeKey });
    listener:any = {
        message: (m) => {
            //console.log(m);
            this.messageHandler(m);
        },
        presence: function (p) {
            // handle presence
            var action = p.action; // Can be join, leave, state-change or timeout
            var channelName = p.channel; // The channel for which the message belongs
            var occupancy = p.occupancy; // No. of users connected with the channel
            var state = p.state; // User State
            var channelGroup = p.subscription; //  The channel group or wildcard subscription match (if exists)
            var publishTime = p.timestamp; // Publish timetoken
            var timetoken = p.timetoken; // Current timetoken
            var uuid = p.uuid; // UUIDs of users who are connected with the channel
            if (action != "interval" || action != "leave") {
                //console.log("presence",p);
            }
        },
        signal: function (s) {
            // handle signal
            console.log("signal", s);
            var channelName = s.channel; // The channel for which the signal belongs
            var channelGroup = s.subscription; // The channel group or wildcard subscription match (if exists)
            var pubTT = s.timetoken; // Publish timetoken
            var msg = s.message; // The Payload
            var publisher = s.publisher; //The Publisher
        },
        user: function (userEvent) {
            console.log("userEvent", userEvent);
            // for Objects, this will trigger when:
            // . user updated
            // . user deleted
        },
        space: function (spaceEvent) {
            console.log("space", spaceEvent);
            // for Objects, this will trigger when:
            // . space updated
            // . space deleted
        },
        membership: function (membershipEvent) {
            console.log("membership", membershipEvent);
            // for Objects, this will trigger when:
            // . user added to a space
            // . user removed from a space
            // . membership updated on a space
        },
        messageAction: function (ma) {
            console.log("messageAction", ma);
            // handle message action
            var channelName = ma.channel; // The channel for which the message belongs
            var publisher = ma.publisher; //The Publisher
            var event = ma.message.event; // message action added or removed
            var type = ma.message.data.type; // message action type
            var value = ma.message.data.value; // message action value
            var messageTimetoken = ma.message.data.messageTimetoken; // The timetoken of the original message
            var actionTimetoken = ma.message.data.actionTimetoken; //The timetoken of the message action
        },
        status: function (s) {
            //console.log("status",s);
            var affectedChannelGroups = s.affectedChannelGroups; // The channel groups affected in the operation, of type array.
            var affectedChannels = s.affectedChannels; // The channels affected in the operation, of type array.
            var category = s.category; //Returns PNConnectedCategory
            var operation = s.operation; //Returns PNSubscribeOperation
            var lastTimetoken = s.lastTimetoken; //The last timetoken used in the subscribe request, of type long.
            var currentTimetoken = s.currentTimetoken; //The current timetoken fetched in the subscribe response, which is going to be used in the next request, of type long.
            var subscribedChannels = s.subscribedChannels; //All the current subscribed channels, of type array.
        }
    };

    constructor() {
        globalThis.channels = {};
        globalThis.activeNumberGames = {};
        globalThis.subscribers = [];
        setInterval(async() => {
            let hasInstalls = await this.checkInstalsLoop();
            this.init(hasInstalls);
        }, 10000);
    }

    async checkInstalsLoop(){
        await ThetaApi.getInstalls(
            data => {
                data.forEach((item) => {
                    let status = ((globalThis.channels[item.user_id]) ? globalThis.channels[item.user_id].showStatus : true);
                    let numberGame = ((globalThis.activeNumberGames[item.user_id]) ? globalThis.activeNumberGames[item.user_id].numberGame : false);
                    let number = ((globalThis.activeNumberGames[item.user_id]) ? globalThis.activeNumberGames[item.user_id].number : 0);
                    let players = ((globalThis.activeNumberGames[item.user_id]) ? globalThis.activeNumberGames[item.user_id].players : {});
                    let channel:Channel = {
                        clientId: item.client_id ,
                        userId: item.user_id,
                        accessToken: item.access_token,
                        prefix: BabbleAip.getStreamerPrefix(),
                        showStatus: status
                    };
                    globalThis.channels[item.user_id] = channel;
                    globalThis.activeNumberGames[item.user_id] = {
                        number: number,
                        numberGame: numberGame,
                        players: players
                    }
                });
            }
        );
        return true
    }

    init(hasInstalls: boolean) {
        if(hasInstalls){
            globalThis.subscribers.splice(0, globalThis.subscribers.length);
            for (let channel in globalThis.channels) {
                globalThis.subscribers.push("chat." + channel);
            }
            this.startPubNub();
        }
    }

    startPubNub() {
        this.pubnub.removeListener(this.listener);
        this.pubnub.unsubscribe({ channels: globalThis.subscribers });
        this.pubnub.subscribe({
            channels: globalThis.subscribers,
            withPresence: true
        });
        this.pubnub.addListener(this.listener);
    }

    messageHandler(msgObject) {
        let channelId = msgObject.channel.replace('chat.', ''); // The channel for which the message belongs
        let pubTT = msgObject.timetoken; // Publish timetoken
        let msg = msgObject.message; // The Payload
        let publisher = msgObject.publisher; //The Publisher
        let msgText = msg.data.text;
        let msgType = msg.type;
        let user = msg.data.user;
        let channelConfig = globalThis.channels[channelId];

        switch (true) {
            case msgType == "system_chat_message":
                console.log("system message", msgObject);
                console.log("is raid", msgText.includes("has raided the stream"));
                if(msgText.includes("has raided the stream")){
                    ThetaApi.sendMsg("RAID HYPE!! :nominal: :nominal: @" + user.username + "went crazy :crazy: Spam Raid in chat everyone!!", channelId);
                }
                break;
            case msgType == "chat_message_" + channelId:
                if (msgText.startsWith(channelConfig.prefix)) {
                    this.runCmd(msgText, channelId);
                }
                break;
            case msgType == "chat_message":
                if (user.id == channelId) {
                    if (msgText.startsWith(channelConfig.prefix)) {
                        this.runCmd(msgText, channelId);
                    }
                } else {
                    this.checkViewHooks(msgText, user, channelId);
                }
                break;
            default:
                this.statusHandler(msg, channelId);
                break;
        }
    }

    statusHandler(msg, channel){
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
            case msgType == "xp":
                ThetaApi.sendMsg("Lets GO @" + user.username + "you just reached level" + msg.data.xp + "GG's in chat everyone", channel);
                break;
        }
    }

    runCmd(msg, channel) {
        msg = msg.toLowerCase().substr(1).split(" ");
        switch (true) {
            case msg[0] == "hello" || msg[0] == "hi":
                ThetaApi.sendMsg("hello", channel);
                break;
            case msg[0] == "num" || msg[0] == "number" || msg[0] == "ng":
                Games.startNumberGame(msg, channel);
                break;
            case msg[0] == "support":
                ThetaApi.sendMsg("Babble Support Discord: https://www.discord.gg/73gusq7", channel);
            break;

            // case msg[0] == "mod" && msg[1].startsWith("@"): NOTE: currently not supported
            //     break;
        }
    }

    checkViewHooks(msg, usr, channel) {
        let ngChannelConfig = globalThis.activeNumberGames[channel];
        if (this.isNormalInteger(msg) && ngChannelConfig.numberGame) {
            Games.numGameManager(msg, usr, channel);
        }
        msg = msg.toLowerCase().split(" ");
        switch (true) {
            case msg[0] == "magic8":
                console.log("8ball");
                Games.play8Ball(usr, channel);
                break;
        }
    }

    isNormalInteger(str) {
        str = str.trim();
        if (!str) {
            return false;
        }
        str = str.replace(/^0+/, "") || "0";
        var n = Math.floor(Number(str));
        return n !== Infinity && String(n) === str && n >= 0;
    }

}

export default new Babble();