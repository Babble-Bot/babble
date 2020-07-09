"use strict";

import fetch from 'node-fetch';
import BabbleAip from './babble.api';
import Helpers from './helpers';
import * as appConfig from '../config.json';


export default class ThetaApi {
    static async getUpTime(channel: any) {
        let channelConfig = BabbleAip.getChannelConfig(channel);
        let url = "https://api.theta.tv/v1/channel/" + (await channelConfig).userId
        const response = await fetch(url);
        const json = await response.json();
        const initTS = parseInt(json.body.start_time);
        const currentTS = Date.now();
        const diff = currentTS - initTS;
        let diffSec = diff / 1000;
        let diffMin = diff / (60 * 1000);
        let diffHour = diff / (60 * 60 * 1000);
        let diffDay = diff / (24 * 60 * 60 * 1000);
        let uptimeMsg = "";
        if (diffDay > 0) {
            uptimeMsg += Math.floor(diffDay) + " days, ";
        }
        if (diffHour > 0) {
            if (diffDay > 0) {
                diffHour -=  Math.floor(diffDay) * 24;
            }
            uptimeMsg += Math.floor(diffHour) + " hours, ";

        }
        if (diffMin > 0) {
            if (diffHour > 0) {
                diffMin -= Math.floor(diffHour) * 60;
            }
            uptimeMsg += Math.floor(diffMin) + " minutes, ";

        }
        if (diffSec > 0) {
            if (diffMin > 0) {
                uptimeMsg += " and ";
                let daysInSeconds = Math.floor(diffDay) * 24 * 60 * 60;
                let hoursInSeconds = Math.floor(diffHour) * 60 * 60;
                let minutesInSeconds = Math.floor(diffMin) * 60;

                diffSec -= daysInSeconds + hoursInSeconds + minutesInSeconds;
            }
            uptimeMsg += Math.floor(diffSec) + " seconds.";

        }
        this.sendMsg("your uptime is " + uptimeMsg, channel);
    }

    static getInstalls = async callback => {
        let url = 'https://api.theta.tv/v1/oauth_application/' + appConfig.clientId + '/oauth_install/list?client_id=' + appConfig.clientId + '&client_secret=' + appConfig.clientSecret;
        const response = await fetch(url);
        const json = await response.json();
        callback(json.body);
    }

    static async getUserFromId(userId) {
        const response = await fetch('https://api.theta.tv/v1/user/' + userId);
        const json = await response.json();
        return json.body;
    }

    static async sendMsg(msg, channel) {
        let channelConfig = BabbleAip.getChannelConfig(channel);
        let body = {
            "type": "chat_message",
            "message": msg,
            "display_name": (await channelConfig).botName,
            "intl": false
        };
        let url = "https://api.theta.tv/v1/channel/" + (await channelConfig).userId + "/channel_action?client_id=" + appConfig.clientId + "&client_secret=" + appConfig.clientSecret;
        fetch(url, {
            method: "POST",
            body: JSON.stringify(body),
            headers: {
                "Authorization": "Bearer " + (await channelConfig).accessToken,
                "Content-Type": "application/json"
            },
        });
    }

    static timedMsg(msg, channel) {
        const intervalInMs = parseInt(msg[1]) * 60000;//convert min to ms
        Helpers.removeItemOnce(msg, "!");
        Helpers.removeItemOnce(msg, "timer");
        Helpers.removeItemOnce(msg, msg[1]);
        msg = msg.toString();
        msg = msg.replace(",", " ");
        setInterval(async () => {
            this.sendMsg(msg,channel);
        },intervalInMs);
    }
}