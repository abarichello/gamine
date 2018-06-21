import * as handler from '../handlers/leaderboard'
import { Router } from 'express'


export function register(router: Router) {
    router.route('/leaderboard/add')
        .post(handler.addEntry)
    router.route('/leaderboard/get')
        .get(handler.getEntry)
    router.route('/leaderboard/top10')
        .get(handler.getTopEntries)
}
