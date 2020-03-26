export default class ThetaApi{
    config: any;
    constructor(config: any){
        this.config = config
    }
    public sendMsg(msg, channel) {
        let body = {
            "type": "chat_message",
            "message": msg
        };
        let result;
        let channelConfig = this.config.channels[channel];
        let url = "https://api.theta.tv/v1/channel/" + channelConfig.userId + "/channel_action?client_id=" + this.config.clientId + "&client_secret=" + this.config.clientSecret;
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
                return res.blob();
            })
            .then(function (blob) {
                result = blob;
            });
    }

    public getUserNameFromId(userId) {
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