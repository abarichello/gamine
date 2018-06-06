require('dotenv-safe').load()
require('source-map-support').install() // Map generated JS source back to TS
import * as http from 'http'
import { createServerInstance } from './setup/express'


const app = createServerInstance()
const port = Number(process.env.PORT) || 3000
http.createServer(app).listen(port, function() {
    console.log(`Express server listening on port ${port}`)
})
