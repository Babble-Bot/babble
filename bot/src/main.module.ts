"use strict";

import PubNub = require('pubnub');
import fetch from 'node-fetch';
import * as config from './config.json';

const pubnub = new PubNub({ subscribeKey: config.subscribeKey });
let initurl = 'https://api.theta.tv/v1/oauth_application/' + config.clientId + '/oauth_install/list?client_id=' + config.clientId + '&client_secret=' + config.clientSecret;
fetch(initurl).then(res => res.text()).then(body => init(body));

function init(body) {
    let data = JSON.parse(body);
    data.body.forEach(function (channel) {
        config.channels.subscribers.push("chat." + channel.user_id);
        config.channels[channel.user_id] = {
            clientId: channel.client_id,
            userId: channel.user_id,
            accessToken: channel.access_token,
        };
    });
    startPubNub();
}

function startPubNub() {
    pubnub.subscribe({
        channels: config.channels.subscribers,
        withPresence: true
    });
    pubnub.addListener({
        message: function (m) {
            // handle messages
            //console.log(m);
            let channelName = m.channel; // The channel for which the message belongs
            let channelGroup = m.subscription; // The channel group or wildcard subscription match (if exists)
            let pubTT = m.timetoken; // Publish timetoken
            let msg = m.message; // The Payload
            let publisher = m.publisher; //The Publisher
            channelName = channelName.replace('chat.', '');
            messageHander(msg, channelName);
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
            if (action != "interval") {
                console.log(p);
            }
        },
        signal: function (s) {
            // handle signal
            console.log(s);
            var channelName = s.channel; // The channel for which the signal belongs
            var channelGroup = s.subscription; // The channel group or wildcard subscription match (if exists)
            var pubTT = s.timetoken; // Publish timetoken
            var msg = s.message; // The Payload
            var publisher = s.publisher; //The Publisher
        },
        user: function (userEvent) {
            console.log(userEvent);
            // for Objects, this will trigger when:
            // . user updated
            // . user deleted
        },
        space: function (spaceEvent) {
            console.log(spaceEvent);
            // for Objects, this will trigger when:
            // . space updated
            // . space deleted
        },
        membership: function (membershipEvent) {
            console.log(membershipEvent);
            // for Objects, this will trigger when:
            // . user added to a space
            // . user removed from a space
            // . membership updated on a space
        },
        messageAction: function (ma) {
            console.log(ma);
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
            console.log(s);
            var affectedChannelGroups = s.affectedChannelGroups; // The channel groups affected in the operation, of type array.
            var affectedChannels = s.affectedChannels; // The channels affected in the operation, of type array.
            var category = s.category; //Returns PNConnectedCategory
            var operation = s.operation; //Returns PNSubscribeOperation
            var lastTimetoken = s.lastTimetoken; //The last timetoken used in the subscribe request, of type long.
            var currentTimetoken = s.currentTimetoken; //The current timetoken fetched in the subscribe response, which is going to be used in the next request, of type long.
            var subscribedChannels = s.subscribedChannels; //All the current subscribed channels, of type array.
        }
    });
}

function messageHander(msg, channel) {
    let msgText = msg.data.text;
    let msgType = msg.type;
    let user = msg.data.user;

    switch (true) {
        case msgType == "hello_message":
            sendMsg("Hello " + user.username + " thanks for joining the channel ", channel);
            break;
        case msgType == "donation":
            sendMsg("Thank you for the" + msg.data.tfuel + " :tfuel: !! " + msg.data.sender.username , channel);
            break;
        case msgType == "follow":
            sendMsg("Thanks for the Fallow !! Welcome " + user.username, channel)
        case msgType == "gift_item":
            sendMsg("Enjoy your Gift!! " + msg.data.recipient.username, channel);
            break;
        case msgType == "chat_message_" + channel:
            if (msgText.startsWith(config.prefix)) {
                runCmd(msgText, channel);
            }
            break;
        case msgType == "chat_message":
            if (user.id == channel) {
                if (msgText.startsWith(config.prefix)) {
                    runCmd(msgText, channel);
                }
            } else {
                checkViewHooks(msgText, user, channel);
            }
            break;
    }
}

function runCmd(msg, channel) {
    msg = msg.toLowerCase().substr(1).split(" ");
    switch (true) {
        case msg[0] == "hello" || msg[0] == "hi":
            sendMsg("hello", channel);
            break;
        case msg[0] == "num" || msg[0] == "number" || msg[0] == "ng":
            startNumberGame(msg, channel);
            break;
        // case msg[0] == "mod" && msg[1].startsWith("@"): NOTE: currently not supported
        //     break;
    }
}

function checkViewHooks(msg, usr, channel) {
    let channelConfig = config.channels[channel];
    msg.toLowerCase();
    switch (true) {
        case isNormalInteger(msg) && channelConfig.numberGame:
            if(parseInt(msg) == channelConfig.number){
                sendMsg("Congrats !! " + usr.username + "Your the winner :flex:", channel);
                channelConfig.number = 0;
                channelConfig.numberGame = false;
                //TODO: auto send gift able item ?
            }
            break;
    }
}

function startNumberGame(msg, channel){
    let channelConfig = config.channels[channel];
    let maxInt = Math.floor(Math.random() * 100) + 1;
    if(msg[1]){
        maxInt = msg[1];
    }
    // if(msg[2]){
    //     channelConfig.limit = msg[2];
    // }
    if(!channelConfig.numberGame){
        channelConfig.numberGame = true;
        channelConfig.number = Math.floor(Math.random() * maxInt) + 1;
        sendMsg("Number Game Started :toastgrin: pick a number between 1 and " + maxInt ,channel);
    }
}

function isNormalInteger(str) {
    str = str.trim();
    if (!str) {
        return false;
    }
    str = str.replace(/^0+/, "") || "0";
    var n = Math.floor(Number(str));
    return n !== Infinity && String(n) === str && n >= 0;
}

function sendMsg(msg, channel) {
    let body = {
        "type": "chat_message",
        "message": msg
    };
    let result;
    let channelConfig = config.channels[channel];
    let url = "https://api.theta.tv/v1/channel/" + channelConfig.userId + "/channel_action?client_id=" + config.clientId + "&client_secret=" + config.clientSecret;
    fetch(url, {
        method: "POST",
        body: JSON.stringify(body),
        headers: {
            "Authorization": "Bearer " + channelConfig.accessToken,
            "Content-Type": "application/json"
        },
    })
        .then(function (res) {
            if (res.ok) {
                console.log(res.statusText + " msssage sent!");
            } else {
                console.log('Request failed.  Returned status of ' + res.status);
            }
            return res.blob();
        })
        .then(function (blob) {
            result = blob;
        });
}

function getUserNameFromId(userId) {
    console.log(userId);
    let username;
    fetch('https://api.theta.tv/v1/user/' + userId)
        .then(res => res.json())
        .then(json => function (json) {
            console.log(json);
            username = json.body.username;
        });
    console.log(username);
    return username;

}