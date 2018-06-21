import * as http from 'http'
import * as express from 'express'
import * as morgan from 'morgan'
import * as cors from 'cors'
import { json } from 'body-parser'


type RequestListener = (req: http.IncomingMessage, res: http.ServerResponse) => void
export function createServerInstance(): RequestListener {
    // Setup express
    const app = express()

    // Log HTTP requests
    if (process.env.NODE_ENV !== 'test') {
        app.use(morgan('dev'))
    }

    // Parse application/json
    app.use(json())

    /* Allow CORS */
    app.use(cors())
    app.options('*', cors())

    /* IMPORTANT: This should be the last registered middleware */
    const { default: router } = require('../routes')
    app.use(router)

    return app
}
