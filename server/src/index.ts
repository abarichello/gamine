require('dotenv-safe').load()
require('source-map-support').install() // Map generated JS source back to TS
import * as https from 'https'
import * as http from 'http'
import { createServerInstance } from './setup/express'
import { readFileSync } from 'fs'


const privateKey = readFileSync('gamine_key')
const credentials = {
    key: privateKey,
    passphrase: process.env.KEY_PASSPHRASE,
}

const app = createServerInstance()
const port = Number(process.env.PORT) || 3000

if (process.env.NODE_ENV === 'development') {
    http.createServer(app).listen(port, function() {
        console.log(`Express HTTP server listening on port ${port}`)
    })
} else {
    https.createServer(credentials, app).listen(port, function() {
        console.log(`Express HTTPS server listening on port ${port}`)
    })
}
