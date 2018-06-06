import { Request, Response, NextFunction } from 'express'


export async function addEntry(req: Request, res: Response, next: NextFunction) {
    const { game, value } = req.body
    console.log(`GAME: ${game}\nVALUE: ${value}`)
    return res.status(200).end()
}
