import { readdirSync } from 'fs'


export async function getFilesFromDirectory<T = any>(path: string): Promise<T[]> {
    const files = []
    for (const filename of readdirSync(path)) {
        if (filename.match(/\.js$/) !== null && filename !== 'index.js') {
            const filePath = './' + filename.replace('.js', '')
            const module = await import(path + filePath)
            console.log(filePath)
            files.push(module)
        }
    }
    return files
}
