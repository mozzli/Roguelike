extends Control


var resolution


#
func _ready():
	resolution = get_viewport_rect().size
	rect_size.y = resolution.y
	$ColorRect.rect_size = resolution
