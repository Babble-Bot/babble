import ThetaApi from './theta.api';

export default class Games{
    config: any;
    constructor(private thetaApi: ThetaApi, config: any){
        this.config = config;
    }
    public startNumberGame(msg, channel) {
        let channelConfig = config.channels[channel];
        let maxInt = Math.floor(Math.random() * 100) + 1; //Default of 100
        if(msg[1] == "kill"){
            channelConfig.numberGame = false;
            channelConfig.number = '';
            this.thetaApi.sendMsg("The Number Game has been cancelled :burnttoast:", channel);
        }else{
            if (msg[1]) {
                maxInt = msg[1];
            }
            if (maxInt < 25) {
                maxInt = 25;
            }
            if (!channelConfig.numberGame) {
                channelConfig.numberGame = true;
                channelConfig.number = Math.floor(Math.random() * maxInt) + 1;
                this.thetaApi.sendMsg("Number Game Started :toastgrin: pick a number between 1 and " + maxInt, channel);
            }
        }

    }

    public play8Ball(usr, channel) {
        let responses = [
            'It is certain',
            'It is decidedly so',
            'Without a doubt',
            'Yes definitely',
            'You may rely on it',
            'As I see it, yes',
            'Most likely',
            'Outlook good',
            'yes',
            'Signs point to yes',
            'Reply hazy try again',
            'Ask again later',
            'Better not tell you now',
            'Cannot predict now',
            'Concentrate and ask again',
            'Do not count on it',
            'My reply is no',
            'My sources say no',
            'Outlook not so good',
            'Very doubtful',
        ];
        let choice = responses[Math.floor(Math.random() * responses.length)];
        let msg = "@" + usr.username + " " + choice;
        console.log(msg);
        this.thetaApi.sendMsg(msg, channel);
    }
}