# Wii Play: Motion Speedrun Mode

## what it does
speedrunning bronze, silver, gold, or platinum medals in wpm requires a mostly fresh save file with all the games unlocked. unlocking all the games from a fresh save file while avoiding collecting any medals/unnecessary unlocks takes about 10 minutes, so running these categories involves getting a save file set up, saving it to an sd card, then going to the wii menu to load this save file every time you reset. this code eliminates the need to do this, allowing the runner to toggle "speedrun mode" on reset.

## how it works
when loading into the game (either initially from the wii menu or on reset), hold down 1 + 2 on the player 1 wii remote. congratulations, you are now in speedrun mode! nothing you do in speedrun mode will write to the save file, so you can run the game with any save file without the risk of losing any medals, high scores, or unlocks. to exit speedrun mode, reset the game while holding down 1 + 2 again, or just restart the game from the wii menu.

## install instructions
you are required to have a homebrewed wii/vwii with [gecko os](https://wiibrew.org/wiki/Gecko_OS) installed (ensure sd cheats are turned on in gecko settings). go to the [releases](https://github.com/dragonz4477/wpm_speedrun_mode/releases) tab, download one of the .gct files, and save it to a folder called `codes` at the root of your sd card. if you are running the **ntsc-u** version of the game, download `SC8E01.gct`. if you are running the **pal** version of the game, download `SC8P01.gct`. launch the game through gecko and it should work just fine.

## special thanks
thank you to [kiwi](https://github.com/kiwi515) for the button combo and disable save logic
