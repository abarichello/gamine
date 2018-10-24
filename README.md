# GAMINE
[![HitCount](http://hits.dwyl.io/abarichello/gamine.svg)](http://hits.dwyl.io/abarichello/gamine) [![pipeline status](https://gitlab.com/BARICHELLO/GAMINE/badges/master/pipeline.svg)](https://gitlab.com/BARICHELLO/GAMINE/commits/master)<br>
<figure>
    <a href="https://www.youtube.com/watch?v=K7O0IjDuenM">
    <img src="https://i.imgur.com/UWcUJgq.png" width="500" align="left"></a>
    <figcaption><br>GAMINE</figcaption>
</figure>
Inspired by the Enigma Machine in the Wolfenstein II game, to be released to Android, IOS, Windows and Linux.
<br>

---

<figure>
    <a href="https://www.youtube.com/watch?v=K7O0IjDuenM">
    <img src="https://i.imgur.com/hBEEw9a.png" width="500" align="center"></a>
    <figcaption><br>GAMINE</figcaption>
</figure>
<br>
<br>
<figure>
    <a href="https://www.youtube.com/watch?v=K7O0IjDuenM">
    <img src="https://i.imgur.com/4IZTbvg.png" width="500" align="center"></a>
    <figcaption><br>Screenshot from Wolfenstein II</figcaption>
</figure>
<br>

## Download / Play Online
- [Play online here](https://barichello.me/games/index.html).
- Download through GitLab CI's [releases](https://gitlab.com/BARICHELLO/GAMINE/-/jobs) or [PlayStore](https://play.google.com/store/apps/details?id=org.barichello.gamine).

## Objective
This game replicates the minigame found in Wolfenstein's II Enigma Machine. You are given 7 figures(levels) and your objective is to match their halves on the selector below.

<br>
<figure>
    <a href="https://www.youtube.com/watch?v=K7O0IjDuenM">
    <img src="https://i.imgur.com/yPMHbVT.png" width="500" align="center"></a>
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

### Scenes/Scripts
```yaml
About.gd - About menu located in the main menu.
Bit.tscn - The bit scene represents a dot, used inside the Piece scene.
Database.gd - File used to save/load your highscores to your device.
Data.gd - Game logic and structures.
Game.gd - Game frontend logic.
GLOBALS.gd - Paths and constants.
Leaderboard.gd - Leaderboard popup.
Main.gd - Root node of the project.
Menu.gd - Main menu frontend.
Network.gd - Network related queries.
Nickname.gd - Popup that handles nickname registering.
PauseMenu.gd - Game popup used for pause.
Piece.gd - A piece represents a 'square' in the game, it's composed of 9 bits.
ResultsMenu.gd - Popup used to send your highscores to the game server.
SocialMediaBox.gd - My reusable social media buttons.
Themes.gd - Popup handling themes and color switching.
```
# Thanks
Thanks to @Batarian711 for providing the logo for the game. Check [#4](https://github.com/aBARICHELLO/GAMINE/issues/4)
