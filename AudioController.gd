extends Node2D

enum audio {FOREST_MAZE, BATTLE_NORMAL, TOWN}

var current_music: Music

func get_audio(new_audio: int) -> Node:
	match(new_audio):
		audio.FOREST_MAZE:
			return $ForestMaze
		audio.BATTLE_NORMAL: return $BattleNormal
		audio.TOWN: return $TownTheme
		_: return null

func play_music(new_audio: Music):
	new_audio.music_fade_in()
	current_music = new_audio

func change_music(new_music: Music):
	current_music.stop()
	current_music = new_music
	current_music.play()

func fade_music_in(new_music: Music):
	current_music.music_fade_out()
	current_music = new_music
	current_music.music_fade_in()
