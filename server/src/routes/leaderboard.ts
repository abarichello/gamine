import * as handler from '../handlers/leaderboard'
import { Router } from 'express'


export function register(router: Router) {
    router.route('/health')
        .get(handler.health)
    router.route('/leaderboard/')
        .get(handler.getEntry)    
        .post(handler.addEntry)
    router.route('/leaderboard/top')
        .get(handler.getTopEntries)
}
