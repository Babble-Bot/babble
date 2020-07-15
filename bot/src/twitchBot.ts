"use strict";

const tmi = require('tmi.js');
import * as appConfig from './config.json';

export default class TwitchBot {
    [x: string]: any;
    client = new tmi.client(appConfig.twitchOpts);

    constructor() {
        console.log("Twitch Bot Running");
        // Register our event handlers (defined below)
        this.client.on('message', this.onMessageHandler);
        this.client.on('connected', this.onConnectedHandler);

        // Connect to Twitch:
        this.client.connect();
    }

    // Called every time a message comes in
    onMessageHandler(target, context, msg, self) {
        if (self) { return; } // Ignore messages from the bot

        // Remove whitespace from chat message
        const msgArray = msg.substr(1).split(" ");
        const commandName = msgArray[0].toLowerCase();
        // If the command is known, let's execute it
        if (commandName === 'hi') {
            this.say(target, "hello form Babble")
            // const num = this.rollDice();
            // this.client.say(target, `You rolled a ${num}`);
            console.log(`* Executed ${commandName} command`);
        } else {
            console.log(`* Unknown command ${msg}`);
        }
    }
    // Function called when the "dice" command is issued
    rollDice(): number {
        const sides = 6;
        return Math.floor(Math.random() * sides) + 1;
    }
    // Called every time the bot connects to Twitch chat
    onConnectedHandler(addr, port) {
        console.log(`* Connected to ${addr}:${port}`);
    }
}

