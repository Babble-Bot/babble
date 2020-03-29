"use strict";

import fetch from 'node-fetch';

const defaultPrefix: BabbleLib.defaultPrefix = "!";

export default class BabbleApi{
    
    static getStreamerPrefix(){
        //TODO: once api for web console is set up to set streamer cmd prefix set it hear if none is set use default
        return defaultPrefix;
    }
}