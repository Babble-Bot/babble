"use strict";

//import fetch from 'node-fetch';
import * as appConfig from '../config.json';



export default class BabbleApi {
    //TODO: once api for web console is set up to set streamer pref's
    static getStreamerPrefix() {//channel will be
        return appConfig.defaultPrefix;
    }
}