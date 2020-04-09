"use strict";

import fetch from 'node-fetch';

globalThis.defaultPrefix = "!";

export default class BabbleApi {
    //TODO: once api for web console is set up to set streamer pref's
    static getStreamerPrefix() {//channel will be
        return globalThis.defaultPrefix;
    }
}