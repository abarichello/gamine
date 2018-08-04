import * as http from 'http'
import * as express from 'express'
import * as morgan from 'morgan'
import * as cors from 'cors'
import { json } from 'body-parser'


type RequestListener = (req: http.IncomingMessage, res: http.ServerResponse) => void
export function createServerInstance(): RequestListener {
    const app = express()

    // Log HTTP requests
    if (process.env.NODE_ENV !== 'test') {
        app.use(morgan('dev'))
    }

    app.use('/scripts', express.static('src/web/scripts'))
    app.use('/css', express.static('src/web/css'))
    app.use(json())
    app.use(cors())
    app.options('*', cors())

    // IMPORTANT: This should be the last registered middleware
    const { default: router } = require('../routes')
    app.use(router)

    return app
}
