extends Camera2D

var mouse_down = false
var mouse_left = false
var mouse_right = false
var mouse_up = false
var scrolling_speed = 6

const FLOAT_EPSILON = 0.00001

func compare_floats(a, b, epsilon = FLOAT_EPSILON):
	return abs(a - b) <= epsilon

func _ready():
	drag_margin_left = 1
	zoom = GameVariables.camera_zoom
	limit_right = GameVariables.map_columns*65 + 250
	limit_bottom = GameVariables.map_rows*48.5 + 200

func _process(_delta):
	change_border_hitboxes()
	global_position = get_camera_screen_center()
	if !GameVariables.gui_is_on:
		check_if_camera_can_be_moved()
	if GameVariables.battle_on == false:
		zoom_progressive()

func zoom_progressive():
	if !is_equal_approx(zoom.x, GameVariables.camera_zoom.x):
		if zoom > GameVariables.camera_zoom:
			if zoom.x != GameVariables.camera_zoom.x:
				zoom.x += -0.01
			if zoom.y != GameVariables.camera_zoom.y:
				zoom.y += -0.01
		else:
			if zoom.x != GameVariables.camera_zoom.x:
				zoom.x += 0.01
			if zoom.y != GameVariables.camera_zoom.y:
				zoom.y += 0.01

func activate_camera():
	if GameVariables.map_on:
		position = GameVariables.active_units[0].get_position()

func check_if_camera_can_be_moved():
	if mouse_down == true:
		position += Vector2(0,scrolling_speed)
	if mouse_left == true:
		position += Vector2(-scrolling_speed,0)
	if mouse_up == true:
		position += Vector2(0,-scrolling_speed)
	if mouse_right == true:
		position += Vector2(scrolling_speed,0)

func _on_ScrollingDownArea_mouse_entered():
	mouse_down = true

func _on_ScrollingDownArea_mouse_exited():
	mouse_down = false

func _on_ScrollingLeftArea_mouse_entered():
	mouse_left = true

func _on_ScrollingLeftArea_mouse_exited():
	mouse_left = false

func _on_ScrollingUpArea_mouse_entered():
	mouse_up = true

func _on_ScrollingUpArea_mouse_exited():
	mouse_up = false

func _on_ScrollingRightArea_mouse_entered():
	mouse_right = true

func _on_ScrollingRightArea_mouse_exited():
	mouse_right = false

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("zoom") && !GameVariables.gui_is_on:
			if zoom.x < 0.99:
				GameVariables.camera_zoom = Vector2(1,1)
			else:
				GameVariables.camera_zoom = Vector2(0.5,0.5)

func change_border_hitboxes():
	var camera_position = global_position
	$ScrollingDownArea/CollisionShape2D.global_position = Vector2(camera_position.x, camera_position.y + (OS.window_size.y/2) * zoom.y)
	$ScrollingUpArea/CollisionShape2D.global_position = Vector2(camera_position.x, camera_position.y - (OS.window_size.y/2) * zoom.y)
	$ScrollingLeftArea/CollisionShape2D.global_position = Vector2(camera_position.x - (OS.window_size.x/2) * zoom.x, camera_position.y)
	$ScrollingRightArea/CollisionShape2D.global_position = Vector2(camera_position.x + (OS.window_size.x/2) * zoom.x, camera_position.y)

func get_camera_edge():
	return get_camera_screen_center() - OS.window_size/2

func zoom_out_camera():
	GameVariables.camera_zoom = Vector2(1,1)
	zoom = Vector2(1,1)

func zoom_in_camera():
	zoom = Vector2(0.5,0.5)
