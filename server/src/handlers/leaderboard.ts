import { Request, Response, NextFunction } from 'express'
import pg from '../setup/database'


export async function addEntry(req: Request, res: Response, next: NextFunction) {
    const { game, nickname, score } = req.body
    console.log(`GAME: ${game}\nSCORE: ${score}`)

    const entry = await pg
        .from(game)
        .insert({ nickname, score })
    return res.status(200).end()
}

export async function getEntry(req: Request, res: Response, next: NextFunction) {
    return res.status(200).end()
}

export async function getTopEntries(req: Request, res: Response, next: NextFunction) {
    const { game } = req.query

    const topEntries = await pg
        .from(game)
        .select('nickname', 'score')
        .count('score')

    return res.status(200).end()
}
