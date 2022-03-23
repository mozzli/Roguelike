extends Camera2D

var mouse_down = false
var mouse_left = false
var mouse_right = false
var mouse_up = false
var scrolling_speed = 6

func _ready():
	zoom.x = GameVariables.camera_zoom
	zoom.y = GameVariables.camera_zoom
	

func _process(_delta):
	if mouse_down == true:
		position += Vector2(0,scrolling_speed)
	if mouse_left == true:
		position += Vector2(-scrolling_speed,0)
	if mouse_up == true:
		position += Vector2(0,-scrolling_speed)
	if mouse_right == true:
		position += Vector2(scrolling_speed,0)
	

func activate_camera():
	position = GameVariables.active_units[2].get_position()


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
