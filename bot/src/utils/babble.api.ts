"use strict";
import fs = require('fs');
import path = require('path');
import * as channelDb from '../../../db/theta/channels.json';
import * as NumberGames from '../../../db/theta/activeNumberGames.json';

const appDir = path.dirname(require.main.filename);
export default class BabbleApi {
    static updateChannelsDB(channels: any) {
        if(channels !== channelDb.channels){
            fs.writeFileSync(path.join(appDir, '../../../../db/theta/channels.json'), JSON.stringify({channels:channels}, null, 2));
        }
    }
    static updateNumGameDB(numberGames: any) {
        if(numberGames !== NumberGames.channels){
            fs.writeFileSync(path.join(appDir, '../../../../db/theta/activeNumberGames.json'), JSON.stringify({channels: numberGames}, null, 2));
        }
    }

    static getChannelConfig(channelId: string):Channel {
        let ChannelConfig: Channel;
        channelDb.channels.forEach((channel) => {
            if(channel.userId === channelId) {
                ChannelConfig = channel;
            }
        })
        return ChannelConfig;
    }

    static getNumGameConfig(channelId: string):NumberGame {
        let numberGameConfig: NumberGame;
        NumberGames.channels.forEach((channel) => {
            if(channel.channelId === channelId) {
                numberGameConfig = channel;
            }
        })
        return numberGameConfig;
    }
}