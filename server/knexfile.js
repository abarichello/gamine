require('dotenv-safe').load()
console.log(process.env.POSTGRES_URI)


module_exports = {
    production: {
        client: 'pg',
        connection: process.env.POSTGRES_URI,
        migrations: {
            directory: __dirname + 'dist/migrations'
        }
    }
}
