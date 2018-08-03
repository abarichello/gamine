import * as handler from '../handlers/leaderboard'
import { Router } from 'express'


export function register(router: Router) {
    router.route('/health')
        .get(handler.health)
    router.route('/')
        .get(handler.getEntry)
        .post(handler.addEntry)
    router.route('/top')
        .get(handler.getTopEntries)
}
