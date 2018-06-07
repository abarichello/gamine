import * as knex from 'knex'
const types = require('pg').types


const Database = knex({
    debug: process.env.KNEX_DEBUG === 'true',
    client: 'pg',
    connection: process.env.DATABASE_URL,
})

export default Database
