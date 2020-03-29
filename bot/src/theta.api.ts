"use strict";

import fetch from 'node-fetch';
import * as appConfig from './config.json';
export default class ThetaApi{
    constructor(){}
    
    static getInstalls(): any {
        let url = 'https://api.theta.tv/v1/oauth_application/' + appConfig.clientId + '/oauth_install/list?client_id=' + appConfig.clientId + '&client_secret=' + appConfig.clientSecret;
        fetch(url).then(res => res.text()).then(async function(body){
             return await body;
        });
    }

    static sendMsg(msg, channel) {
        let body = {
            "type": "chat_message",
            "message": msg
        };
        let channelConfig = BabbleLib.channels[channel];
        let url = "https://api.theta.tv/v1/channel/" + channelConfig.userId + "/channel_action?client_id=" + appConfig.clientId + "&client_secret=" + appConfig.clientSecret;
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
        })
        .then(body => body);
    }

    static getUserNameFromId(userId): string {
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
}