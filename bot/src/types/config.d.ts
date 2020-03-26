type GlobalConfig = (config: object) => void

declare module NodeJS {
    interface Global {
        globalConfig: GlobalConfig
    }
}

declare const globalConfig: GlobalConfig;