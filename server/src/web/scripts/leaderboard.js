const uri = 'https://leaderboard.barichello.me/'

axios.get(uri, {
    params: { type: 'round' }
}).then(function(response) {
    fillLeaderboard('roundTable', response.data.topEntries)
})

axios.get(uri, {
    params: { type: 'level' }
}).then(function(response) {
    fillLeaderboard('levelTable', response.data.topEntries)
})

function fillLeaderboard(tag, data) {
    let rank = 1
    let table = document.getElementById(tag)
    for (entry of data) {
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
