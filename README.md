# GAMINE
[![HitCount](http://hits.dwyl.io/abarichello/gamine.svg)](http://hits.dwyl.io/abarichello/gamine)<br>
Inspired by the Enigma Machine in the Wolfenstein II game, to be released to Android, IOS, Windows and Linux.
<br>
<br>

<figure>
    <a href="https://www.youtube.com/watch?v=K7O0IjDuenM">
    <img src="https://i.imgur.com/xKDnLmM.png" width="500" align="center"></a>
    <figcaption><br>GAMINE (In development)</figcaption>
</figure>
<br>
<br>
<figure>
    <a href="https://www.youtube.com/watch?v=K7O0IjDuenM">
    <img src="https://i.imgur.com/4IZTbvg.png" width="500" align="center"></a>
    <figcaption><br>Screenshot from Wolfenstein II</figcaption>
</figure>
<br>

## Download
[Releases](https://github.com/aBARICHELLO/GAMINE/releases).

## Objective
This game replicates the minigame found in Wolfenstein's II Enigma Machine. You are given 7 figures(levels) and your objective is to match their halves on the selector below.

<br>
<figure>
    <a href="https://www.youtube.com/watch?v=K7O0IjDuenM">
    <img src="https://i.imgur.com/WIcDDKc.png" width="500" align="center"></a>
    <figcaption><br>This picture shows the center selector matching the first level, pressing enter progresses you to level 2.</figcaption>
</figure>

## How to Play

Use your arrow keys or on screen buttons to move the upper and lower selectors at the bottom of the screen, if you think highlighted middle row matches your current level press Enter (or the row itself on mobile) to advance to the next level.
<br>
The game is completed after finishing all 7 levels.

## Highscores
Acess the game leaderboard using this link: [`leaderboard.barichello.me`](https://leaderboard.barichello.me/)

# Running
To play the game you can check the [Releases](https://github.com/aBARICHELLO/GAMINE/releases) tab and download the wanted version that matches your OS.<br>
To modify the game locally download [Godot Engine](https://godotengine.org/) and open the `game/project.godot` file.<br>
To run the server locally:<br>
1. Copy `server/.env.example` to `server/.env`<br> 
2. Setup database tables with `./db-migrate up`<br>
3. Install dependencies with `yarn`<br>
4. Run using `yarn run start`.<br>

# Game Structure

Godot's main tree scene structure during playtime:
<br>
```yaml
root:
  Main:
    - Menu:
      - Leaderboard
    - Network
    - GLOBALS
    - Game:
      - Data
```
<br>
Full game tree:<br>

`TODO`
