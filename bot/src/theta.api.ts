"use strict";

import fetch from 'node-fetch';
import * as appConfig from './config.json';


export default class ThetaApi{

    static getInstalls = async callback => {
        let url = 'https://api.theta.tv/v1/oauth_application/' + appConfig.clientId + '/oauth_install/list?client_id=' + appConfig.clientId + '&client_secret=' + appConfig.clientSecret;
        const response = await fetch(url);
        const json = await response.json();
        callback(json.body);
    }

    static async getUserFromId(userId){
        const response = await fetch('https://api.theta.tv/v1/user/' + userId);
        const json = await response.json();
        return json.body;
    }

    static sendMsg(msg, channel) {
        let body = {
            "type": "chat_message",
            "message": msg
        };
        let channelConfig = globalThis.channels[channel];
        let url = "https://api.theta.tv/v1/channel/" + channelConfig.userId + "/channel_action?client_id=" + appConfig.clientId + "&client_secret=" + appConfig.clientSecret;
        fetch(url, {
            method: "POST",
            body: JSON.stringify(body),
            headers: {
                "Authorization": "Bearer " + channelConfig.accessToken,
                "Content-Type": "application/json"
            },
        });
    }
}