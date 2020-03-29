// Type definitions for [BabbleLib] [1.0]
// Project: [Babble]
// Definitions by: [Evan Lynch] <[http://babblechatbot.com/]>

/*~ If this library is callable (e.g. can be invoked as myLib(3)),
 *~ include those call signatures here.
 *~ Otherwise, delete this section.
 */
//declare function BabbleLib(a: string): string;
//declare function myLib(a: number): number;

/*~ If you want the name of this library to be a valid type name,
 *~ you can do so here.
 *~
 *~ For example, this allows us to write 'var x: myLib';
 *~ Be sure this actually makes sense! If it doesn't, just
 *~ delete this declaration and add types inside the namespace below.
 */

interface Player{
    userId: string,
    lastGuess: string,
    tres: Tres
}

interface Channel {
    clientId: string;
    userId: string;
    accessToken: string;
    prefix: string;
    numberGame?: boolean;
}

interface Tres{
    [index: number]: string;
}


// interface myLib {
//     name: string;
//     length: number;
//     extras?: string[];
// }

/*~ If your library has properties exposed on a global variable,
 *~ place them here.
 *~ You should also place types (interfaces and type alias) here.
 */
export declare namespace BabbleLib {
    //~ We can write 'myLib.timeout = 50;'
    export var defaultPrefix: string;
    export var subscriber: string;
    export var subscribers: subscriber;
    export var channels: Channels;
    export var activeNumberGames: ActiveNumberGames;

    //~ We can access 'myLib.version', but not change it
    const version: string;

    //~ There's some class we can create via 'let c = new myLib.Cat(42)'
    //~ Or reference e.g. 'function f(c: myLib.Cat) { ... }
    // class Channel{
    //     constructor(channel: Channel);
    //     channel: Channel;
    // }

    //~ We can declare a variable as
    //~   'var s: myLib.CatSettings = { weight: 5, name: "Maru" };'

    interface Subscribers {
        push(arg0: subscriber);
        [index: number]: subscriber;
    }

    interface ActiveNumberGames {
        [index: string]: NumberGame;
    }

    interface NumberGame {
        number: number,
        players: Players
    }

    interface Channels {
        [index: string]: Channel
    }

    interface Players {
        [index: string]: Player
    }

    //~ We can write 'const v: myLib.VetID = 42;'
    //~  or 'const v: myLib.VetID = "bob";'
    // type VetID = string | number;
    type defaultPrefix = string;
    type subscriber = string;

    //~ We can invoke 'myLib.checkCat(c)' or 'myLib.checkCat(c, v);'
    function getDefaultPrefix(prefix: defaultPrefix);
}
