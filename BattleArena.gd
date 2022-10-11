extends Control

var start_resolution = Vector2(40,40)
var max_resolution
var resolution
var transition_on = false
var window_opening_speed_x = 10
var window_opening_speed_y = 10
var trasition_ready = false
var show_background

func prepare_battle(player, enemy, terrain):
	show_forest()
	print(player)
	print(enemy)
	print(terrain)

func _ready():
	$BattleFadeOut/ColorRect.rect_size = get_viewport_rect().size
	max_resolution = get_viewport_rect().size
	rect_size = start_resolution

func show_forest():
	GameVariables.gui_is_on = true
	GameVariables.battle_on = true
	transition_process()
	yield($BattleFadeOut/ColorRect/AnimationPlayer, "animation_finished")
	yield(get_tree().create_timer(0.5), "timeout")
	$BattleFadeOut/ColorRect.material.set_shader_param("cutoff",1)
	popup_plains()
	get_parent().get_node("AudioStreamPlayer").volume_down()

func transition_process():
	$BattleFadeOut.play_shader()
	transition_on = false
	
func popup_plains():
	get_parent().get_node("Camera2D").zoom_out_camera()
	$BackgroundPlains.popup()
	$BackgroundPlains.rect_position = get_node("../Camera2D").get_camera_edge()
	$BackgroundPlains/Plains/ColorRect.rect_size = get_viewport_rect().size
