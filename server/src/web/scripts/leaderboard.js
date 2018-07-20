const uri = 'http://localhost:3000'

var xhr = new XMLHttpRequest()
xhr.open('GET', uri + '/leaderboard/top?game=gamine&type=round&limit=25', true)
xhr.send()
xhr.onreadystatechange = generateLeaderboard

function generateLeaderboard(err) {
    if (xhr.status !== 200) {
        return
    }

    var table = document.getElementById('leaderboardTable')
    for (entry of JSON.parse(xhr.response).topEntries) {
        var newRow = table.insertRow(-1)
        var nicknameCell = newRow.insertCell(-1)
        var scoreCell = newRow.insertCell(-1)
        nicknameCell.innerHTML = entry.nickname
        scoreCell.innerHTML = entry.score
    }
}

window.onload = generateLeaderboard
