import * as handler from '../handlers/leaderboard'
import { Router } from 'express'


export function register(router: Router) {
    router.route('/leaderboard/add')
        .post(handler.addEntry)
}
