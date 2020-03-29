"use strict";

import PubNub = require('pubnub');
import fetch from 'node-fetch';
import * as config from './config.json';

const pubnub = new PubNub({ subscribeKey: config.subscribeKey });
const listener = {
    message: function (m) {
        // handle messages
        //console.log(m);
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

let initurl = 'https://api.theta.tv/v1/oauth_application/' + config.clientId + '/oauth_install/list?client_id=' + config.clientId + '&client_secret=' + config.clientSecret;

function getInstalls() {
    fetch(initurl).then(res => res.text()).then(body => init(body));
}

function init(body) {
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
    startPubNub();
}

function startPubNub() {
    pubnub.removeListener(listener);
    pubnub.unsubscribe({ channels: config.subscribers });
    pubnub.subscribe({
        channels: config.subscribers,
        withPresence: true
    });
    pubnub.addListener(listener);
}

function messageHandler(msg, channel) {
    let msgText = msg.data.text;
    let msgType = msg.type;
    let user = msg.data.user;
    let channelConfig = config.channels[channel];

    switch (true) {
        case msgType == "hello_message":
            sendMsg("Hello @" + user.username + " thanks for coming by, if you like this channel please follow!", channel);
            break;
        case msgType == "donation":
            sendMsg("Thank you for the " + msg.data.tfuel + " :tfuel: !! @" + msg.data.sender.username, channel);
            break;
        case msgType == "follow":
            sendMsg("Thanks for the Follow !! Welcome @" + user.username, channel);
            break;
        case msgType == "gift_item":
            sendMsg("Enjoy your Gift!! @" + msg.data.recipient.username, channel);
            break;
        case msgType == "subscribe":
            sendMsg("Thanks for the Sub and Support! @" + user.username, channel);
            break;
        case msgType == "gift_subscribe":
            sendMsg("Thank you @" + msg.data.sender.username + "for gifting @" + msg.data.recipient.username + msg.data.subscribe, channel);
            break;
        case msgType == "xp":
            sendMsg("Lets GO @" + user.username + "you just reached level" + msg.data.xp + "GG's in chat everyone", channel);
            break;
        case msgType == "chat_message_" + channel:
            if (msgText.startsWith(channelConfig.prefix)) {
                runCmd(msgText, channel);
                //runCmd(msgText, user, channel);
            }
            break;
        case msgType == "chat_message":
            if (user.id == channel) {
                if (msgText.startsWith(channelConfig.prefix)) {
                    runCmd(msgText, channel);
                    //runCmd(msgText, user, channel);
                }
            } else {
                checkViewHooks(msgText, user, channel);
            }
            break;
    }
}

function runCmd(msg, channel) {
    // let channelConfig = config.channels[channel];
    // if (isNormalInteger(msg) && channelConfig.numberGame) {
    //     numGameManager(msg, usr, channel);
    // }
    msg = msg.toLowerCase().substr(1).split(" ");
    switch (true) {
        case msg[0] == "hello" || msg[0] == "hi":
            sendMsg("hello", channel);
            break;
        case msg[0] == "num" || msg[0] == "number" || msg[0] == "ng":
            startNumberGame(msg, channel);
            break;
        case msg[0] == "support":
            sendMsg("Babble Support Discord: https://www.discord.gg/73gusq7", channel);
            break;
        // case msg[0] == "mod" && msg[1].startsWith("@"): NOTE: currently not supported
        //     break;
    }
}

function checkViewHooks(msg, usr, channel) {
    let ngChannelConfig = config.activeNumberGames[channel];
    if (isNormalInteger(msg) && ngChannelConfig.numberGame) {
        numGameManager(msg, usr, channel);
    }
    msg = msg.toLowerCase().substr(1).split(" ");
    switch (true) {
        case msg[0] == "magic8":
            play8Ball(usr, channel);
            break;
    }
}

function startNumberGame(msg, channel) {
    let channelConfig = config.channels[channel];
    let ngChannelConfig = config.activeNumberGames[channel];
    let maxInt = Math.floor(Math.random() * 100) + 1; //Default of 100
    if (msg[1] == "kill") {
        channelConfig.numberGame = false;
        ngChannelConfig = {number: 0, players: {}};
        sendMsg("The Number Game has been cancelled :burnttoast:", channel);
    } else {
        console.log(msg[1])
        if (msg[1]) {
            maxInt = msg[1];
        }
        if (maxInt < 25) {
            maxInt = 25;
        }
        console.log(maxInt);
        if (!channelConfig.numberGame) {
            channelConfig.numberGame = true;
            ngChannelConfig.number = Math.floor(Math.random() * maxInt) + 1;
            sendMsg("Number Game Started :toastgrin: pick a number between 1 and " + maxInt, channel);
            console.log("winnering number", ngChannelConfig.number);
        }
    }

}

function numGameManager(msg, usr, channel) {
    let guess = parseInt(msg);
    let channelConfig = config.channels[channel];
    let ngChannelConfig = config.activeNumberGames[channel];
    let ngPlayer = ngChannelConfig.players[usr.id];
    ngPlayer.guesses.push(guess);
    if (!ngPlayer.lastGuess) {
        ngPlayer.lastGuess = guess;
    }

    if (guess == ngPlayer.lastGuess + 1 || guess == ngPlayer.lastGuess - 1) {
        sendMsg("@" + usr.username + " Sorry but you guess's can not be consecutive ie. 1 2 3 or 3 2 1", channel);
    } else {
        ngPlayer.lastGuess = guess;
    }
    if (guess == ngChannelConfig.number) {
        sendMsg("Congrats !! @" + usr.username + " Your the winner :flex:", channel);
        ngChannelConfig.number = 0;
        channelConfig.numberGame = false;
        ngChannelConfig.players = {};
        //TODO: auto send gift able item ?
    }
}

function play8Ball(usr, channel) {
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
    sendMsg(msg, channel);
}

function isNormalInteger(str: string) {
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

setInterval(getInstalls, 5000);