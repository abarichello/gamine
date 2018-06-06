import Router from 'express-promise-router'
import { Request, Response, NextFunction } from 'express'
import { getFilesFromDirectory } from '../utils'


async function setup() {
    const routes = await getFilesFromDirectory(__dirname + '/')
    for (const { register } of routes) {
        register(router)
    }
    console.log(`Registered a total of ${routes.length} routes`)

    function errorHandler(err: any, req: Request, res: Response, next: NextFunction) {
        console.error(err)
        res.status(500).end()
    }
    router.use(errorHandler)
}

setup().then(() => console.log('-- LOADED ROUTES --\n'))

const router = Router()
export default router
