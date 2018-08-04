import * as handler from '../handlers/leaderboard'
import { Router } from 'express'


export function register(router: Router) {
    router.route('/health')
        .get(handler.health)
    router.route('/')
        .get(handler.getTopEntries)
    router.route('/entry')
        .get(handler.getEntry)
        .post(handler.addEntry)
}
