extends Control

var resolution
var town_opened = false
onready var music = get_parent().get_node("Audio")

func _ready():
	resolution = get_viewport_rect().size
	rect_size = resolution
	$Popup.rect_size = resolution
	$Popup/Sprite/ColorRect.rect_size = resolution

func show_town():
	GameVariables.gui_is_on = true
	town_opened = true
	music.fade_music_in(music.get_audio(music.audio.TOWN))
	$Popup.popup()

func _process(_delta):
	if town_opened:
		$Popup.set_position(get_node("../Camera2D").get_camera_position() - Vector2(resolution/2))

func _on_Button_button_up():
	print("im on it")
	music.fade_music_in(music.get_audio(music.audio.FOREST_MAZE))
	$Popup.hide()
	town_opened = false
	GameVariables.gui_is_on = false
	GameVariables.object_under_player = null
