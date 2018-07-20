const uri = 'http://localhost:3000'

let xhr = new XMLHttpRequest()
xhr.onreadystatechange = generateLeaderboard
xhr.open('GET', uri + '/leaderboard/top?game=gamine&type=round&limit=25', false)
xhr.send()

function generateLeaderboard() {
    if (xhr.status !== 200) {
        return
    }

    let rank = 1
    let table = document.getElementById('leaderboardTable')
    console.log(JSON.parse(xhr.response).topEntries)
    for (entry of JSON.parse(xhr.response).topEntries) {
        let newRow = table.insertRow(-1)

        let rankCell = newRow.insertCell(-1)
        let nicknameCell = newRow.insertCell(-1)
        let typeCell = newRow.insertCell(-1)
        let scoreCell = newRow.insertCell(-1)
        let addedCell = newRow.insertCell(-1)
        
        rankCell.innerHTML = rank++
        nicknameCell.innerHTML = entry.nickname
        typeCell.innerHTML = entry.type
        scoreCell.innerHTML = entry.score
        addedCell.innerHTML = entry.added
    }
}
