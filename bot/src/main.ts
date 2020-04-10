"use strict";
import PubNub = require('pubnub');
import * as appConfig from './config.json';
import ThetaApi from './utils/theta.api';
import BabbleAip from './utils/babble.api';
import BabbleCmd from './utils/commands';
import Games from './games';


class Babble {
    pubnub: any = new PubNub({ subscribeKey: appConfig.subscribeKey });
    listener: any = {
        message: (m) => { this.messageHandler(m); },
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
        setInterval(async () => {
            let hasInstalls = await this.checkInstalsLoop();
            this.init(hasInstalls);
        }, 10000);
    }

    async checkInstalsLoop() {
        await ThetaApi.getInstalls(
            data => {
                data.forEach((item) => {
                    let status = ((globalThis.channels[item.user_id]) ? globalThis.channels[item.user_id].showStatus : true);
                    let activeNumberGame = ((globalThis.activeNumberGames[item.user_id]) ? globalThis.activeNumberGames[item.user_id] : {
                        active: false,
                        winningNumber: 0,
                        players: {},
                        lastGame: {
                            maxInt: 0
                        }
                    });
                    let channel: Channel = {
                        clientId: item.client_id,
                        userId: item.user_id,
                        accessToken: item.access_token,
                        prefix: BabbleAip.getStreamerPrefix(),
                        showStatus: status
                    };
                    globalThis.channels[item.user_id] = channel;
                    globalThis.activeNumberGames[item.user_id] = activeNumberGame;
                });
            }
        );
        // console.log(globalThis.activeNumberGames["usrxhgay62cewzpiymn"]);
        // console.log(globalThis.activeNumberGames["usrxhgay62cewzpiymn"].players);
        return true
    }

    init(hasInstalls: boolean) {
        if (hasInstalls) {
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
        let ngChannelConfig = globalThis.activeNumberGames[channelId];
        let onlyNumRegx = /^\d+$/;

        switch (true) {
            case msgType == "system_chat_message":
                console.log("system message", msgObject);
                console.log("is raid", msgText.includes("has raided the stream"));
                if (msgText.includes("has raided the stream")) {
                    ThetaApi.sendMsg("RAID HYPE!! :nominal: :nominal: @" + user.username + "went crazy :crazy: Spam Raid in chat everyone!!", channelId);
                }
                break;
            case msgType.includes("chat_message"):
                if (ngChannelConfig.active && onlyNumRegx.test(msgText)) {
                    Games.numGameManager(msgText, user, channelId);
                }
                if (msgText.startsWith(channelConfig.prefix)) {
                    if (user.type == "owner") {
                        BabbleCmd.runCmd(msgText, user, channelId);
                    } else if (user.type == "moderator") {
                        BabbleCmd.modCmd(msgText, user, channelId);
                    } else {
                        ThetaApi.sendMsg("Sorry but you do not have Permission to do that", channelId);
                    }
                }else{
                    if(msgText.startsWith(globalThis.defaultPrefix)) {
                        BabbleCmd.checkViewHooks(msgText, user, channelId);
                    }
                }
                break;
            default:
                BabbleCmd.statusHandler(msg, channelId);
                break;
        }
    }


}

export default new Babble();