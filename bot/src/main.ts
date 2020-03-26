"use strict";

import PubNub = require('pubnub');
import fetch from 'node-fetch';
import * as config from './config.json';
import ThetaApi from './theta.api';
import Games from './games';


export default class babble{
    constructor(private thetaApi: ThetaApi, private games: Games){
        setInterval(this.getInstalls, 5000);
    }
    pubnub: any = new PubNub({ subscribeKey: config.subscribeKey });
    listener: any = {
        message: function (m) {
            // handle messages
            console.log(m);
            let channelName = m.channel; // The channel for which the message belongs
            let channelGroup = m.subscription; // The channel group or wildcard subscription match (if exists)
            let pubTT = m.timetoken; // Publish timetoken
            let msg = m.message; // The Payload
            let publisher = m.publisher; //The Publisher
            channelName = channelName.replace('chat.', '');
            messageHandler(msg, channelName);
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

    initurl: string = 'https://api.theta.tv/v1/oauth_application/' + config.clientId + '/oauth_install/list?client_id=' + config.clientId + '&client_secret=' + config.clientSecret;

    getInstalls() {
        fetch(this.initurl).then(res => res.text()).then(body => this.init(body));
    }

    init(body) {
        let data = JSON.parse(body);
        config.subscribers.splice(0, config.subscribers.length);
        data.body.forEach(function (channel) {
            config.channels[channel.user_id] = {
                clientId: channel.client_id,
                userId: channel.user_id,
                accessToken: channel.access_token,
            };
        });
        for (let channel in config.channels) {
            config.subscribers.push("chat." + channel);
        }
        //console.log(config);//ONLY for debuging
        globalConfig(config);
        this.startPubNub();
    }

    startPubNub() {
        this.pubnub.removeListener(this.listener);
        this.pubnub.unsubscribe({ channels: config.subscribers });
        this.pubnub.subscribe({
            channels: config.subscribers,
            withPresence: true
        });
        this.pubnub.addListener(this.listener);
    }

    messageHandler(msg, channel) {
        let msgText = msg.data.text;
        let msgType = msg.type;
        let user = msg.data.user;

        switch (true) {
            case msgType == "hello_message":
                this.thetaApi.sendMsg("Hello @" + user.username + " thanks for joining the channel ", channel);
                break;
            case msgType == "donation":
                this.thetaApi.sendMsg("Thank you for the " + msg.data.tfuel + " :tfuel: !! @" + msg.data.sender.username, channel);
                break;
            case msgType == "follow":
                this.thetaApi.sendMsg("Thanks for the Follow !! Welcome @" + user.username, channel);
                break;
            case msgType == "gift_item":
                this.thetaApi.sendMsg("Enjoy your Gift!! @" + msg.data.recipient.username, channel);
                break;
            case msgType == "chat_message_" + channel:
                if (msgText.startsWith(config.prefix)) {
                    this.runCmd(msgText, channel);
                }
                break;
            case msgType == "chat_message":
                if (user.id == channel) {
                    if (msgText.startsWith(config.prefix)) {
                        this.runCmd(msgText, channel);
                        //checkViewHooks(msgText, user, channel);
                    }
                } else {
                    this.checkViewHooks(msgText, user, channel);
                }
                break;
        }
    }

    runCmd(msg, channel) {
        msg = msg.toLowerCase().substr(1).split(" ");
        switch (true) {
            case msg[0] == "hello" || msg[0] == "hi":
                this.thetaApi.sendMsg("hello", channel);
                break;
            case msg[0] == "num" || msg[0] == "number" || msg[0] == "ng":
                this.games.startNumberGame(msg, channel);
                break;
            // case msg[0] == "mod" && msg[1].startsWith("@"): NOTE: currently not supported
            //     break;
        }
    }

    checkViewHooks(msg, usr, channel) {
        msg = msg.toLowerCase().substr(1).split(" ");
        let channelConfig = config.channels[channel];
        msg.toLowerCase();
        switch (true) {
            case this.isNormalInteger(msg) && channelConfig.numberGame:
                if (parseInt(msg) == channelConfig.number) {
                    this.thetaApi.sendMsg("Congrats !! @" + usr.username + " Your the winner :flex:", channel);
                    channelConfig.number = 0;
                    channelConfig.numberGame = false;
                    //TODO: auto send gift able item ?
                }//TODO: add logic to stop spaming
                break;
            case msg[0] == "8":
                this.games.play8Ball(usr, channel);
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
