function generateLeaderboard() {
    var table = document.getElementById('leaderboardTable')
    var newRow = table.insertRow(-1)
    var cell1 = newRow.insertCell(-1)
    var cell2 = newRow.insertCell(-1)
    cell1.innerHTML = 'NEW CELL1'
    cell2.innerHTML = 'NEW CELL2'
}

window.onload = generateLeaderboard
