"use strict";
import fs = require('fs');
import path = require('path');
import * as channelDb from '../../../db/theta/channels.json';
import * as NumberGames from '../../../db/theta/activeNumberGames.json';

const appDir = path.dirname(require.main.filename);
export default class BabbleApi {
    static updateChannelsDB(channels: any) {
        if(channels !== channelDb.channels){
            const data = {
                channels: channels
            };
            fs.writeFileSync(path.join(appDir, '../../../../db/theta/channels.json'), JSON.stringify(data, null, 2));
        }
    }
    static updateNumGameDB(numberGames: any) {
        if(numberGames !== NumberGames.channels){
            const data = {
                channels: numberGames
            };
            fs.writeFileSync(path.join(appDir, '../../../../db/theta/activeNumberGames.json'), JSON.stringify(data, null, 2));
        }
    }
    static getChannelConfig(channelId): any {
        channelDb.channels.forEach((channel) => {
            if(channel.userId === channelId) {
                return channel;
            }
        })
    }

    static getNumGameConfig(channelId): any {
        NumberGames.channels.forEach((channel) => {
            if(channel.channelId === channelId) {
                return channel;
            }
        })
    }
}