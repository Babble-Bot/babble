"use strict";

import thetaBot from "./thetaBot"
import twitchBot from './twitchBot'

class Babble {
    constructor() {
        new thetaBot();
        new twitchBot();
    }

}

export default new Babble();
