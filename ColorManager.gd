extends Node

func change_color_default(objects_sprite):
	objects_sprite.modulate.r = 1
	objects_sprite.modulate.g = 1
	objects_sprite.modulate.b = 1

func change_color_end_turn(objects_sprite):
	objects_sprite.modulate.r = 0.5
	objects_sprite.modulate.g = 0.5
	objects_sprite.modulate.b = 0.5

func change_color_selected(objects_sprite):
	objects_sprite.modulate.r = 1
	objects_sprite.modulate.g = 0.27
	objects_sprite.modulate.b = 0
