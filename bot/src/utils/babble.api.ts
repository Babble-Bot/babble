"use strict";
import fs = require('fs');
import path = require('path');

const appDir = path.dirname(require.main.filename);
export default class BabbleApi {
    static updatePrefix(msg: any, channelId: any) {
        let rawData = fs.readFileSync(path.join(appDir,'../../../../db/theta/channels.json'));
        let channelDb = JSON.parse(rawData.toString());
        channelDb.channels.forEach((channel) => {
            if(channel.userId === channelId) {
                channel.prefix = msg[1];
                fs.writeFileSync(path.join(appDir, '../../../../db/theta/channels.json'), JSON.stringify({channels:channels}, null, 2));
            }
        });
    }
    static updateBotName(msg: any, channelId: any) {
        let rawData = fs.readFileSync(path.join(appDir,'../../../../db/theta/channels.json'));
        let channelDb = JSON.parse(rawData.toString());
        channelDb.channels.forEach((channel) => {
            if(channel.userId === channelId) {
                channel.botName = msg[1];
                fs.writeFileSync(path.join(appDir, '../../../../db/theta/channels.json'), JSON.stringify({channels:channels}, null, 2));
            }
        });
    }
    static updateChannelsDB(channels: any) {
        let rawData = fs.readFileSync(path.join(appDir,'../../../../db/theta/channels.json'));
        let channelDb = JSON.parse(rawData.toString());
        if(channels !== channelDb.channels){
            fs.writeFileSync(path.join(appDir, '../../../../db/theta/channels.json'), JSON.stringify({channels:channels}, null, 2));
        }
    }
    static updateNumGameDB(numberGames: any) {
        let rawData = fs.readFileSync(path.join(appDir,'../../../../db/theta/activeNumberGames.json'));
        let NumberGames = JSON.parse(rawData.toString());
        if(numberGames !== NumberGames.channels){
            fs.writeFileSync(path.join(appDir, '../../../../db/theta/activeNumberGames.json'), JSON.stringify({channels: numberGames}, null, 2));
        }
    }

    static updateNumGameChannelConfig(channelId: string, updatedNumberGameConfig: any) {
        let rawData = fs.readFileSync(path.join(appDir,'../../../../db/theta/activeNumberGames.json'));
        let NumberGames = JSON.parse(rawData.toString());
        NumberGames.channels.forEach((channel, i) => {
            if(channel.channelId === channelId) {
                NumberGames.channels[i] = updatedNumberGameConfig;
            }
        });
        fs.writeFileSync(path.join(appDir, '../../../../db/theta/activeNumberGames.json'), JSON.stringify({channels: NumberGames}, null, 2));
    }

    static getChannelConfig(channelId: string):Channel {
        let rawData = fs.readFileSync(path.join(appDir,'../../../../db/theta/channels.json'));
        let channelDb = JSON.parse(rawData.toString());
        let ChannelConfig: Channel;
        channelDb.channels.forEach((channel) => {
            if(channel.userId === channelId) {
                ChannelConfig = channel;
            }
        });
        return ChannelConfig;
    }

    static getNumGameConfig(channelId: string):NumberGame {
        let rawData = fs.readFileSync(path.join(appDir,'../../../../db/theta/activeNumberGames.json'));
        let NumberGames = JSON.parse(rawData.toString());
        let numberGameConfig: NumberGame;
        NumberGames.channels.forEach((channel) => {
            if(channel.channelId === channelId) {
                numberGameConfig = channel;
            }
        });
        return numberGameConfig;
    }
}