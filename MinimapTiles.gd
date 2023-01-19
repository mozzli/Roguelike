extends Node2D

enum mini_tiles {HERO = 22, ENEMY = 23, TOWN = 24, BASE = 25 }

onready var main_map: TileMap = MovementUtils.map
onready var fog_map: TileMap = MovementUtils.fog_map

func _process(_delta):
	update_minimap()

func update_minimap():
	for row in range(-1,GameVariables.map_rows+1):
		for column in range(-1,GameVariables.map_columns+1):
			$Map.set_cell(row, column, MovementUtils.map.get_cell(row,column))
			$FogOfWar.set_cell(row, column, MovementUtils.fog_map.get_cell(row,column))
	for town in GameVariables.towns:
		$Map.set_cell(town.get_tile_position().x,town.get_tile_position().y,mini_tiles.TOWN)
	for unit in GameVariables.active_units:
		$Map.set_cell(unit.get_tile().x,unit.get_tile().y,mini_tiles.HERO)
	for enemy in GameVariables.enemies:
		if enemy.visible == true:
			$Map.set_cell(enemy.get_tile_position().x,enemy.get_tile_position().y,mini_tiles.ENEMY)
	if GameVariables.base != null:
		$Map.set_cell(GameVariables.base.get_tile_position().x,GameVariables.base.get_tile_position().y, mini_tiles.BASE )

func update_visibility():
	for row in range(-1,GameVariables.map_rows+1):
		for column in range(-1,GameVariables.map_columns+1):
			$FogOfWar.set_cell(row, column, MovementUtils.fog_map.get_cell(row,column))

func update_units():
	for unit in GameVariables.active_units:
		$Map.set_cell(unit.get_tile().x,unit.get_tile().y,mini_tiles.HERO)
	for enemy in GameVariables.enemies:
		if enemy.visible == true:
			$Map.set_cell(enemy.get_tile_position().x,enemy.get_tile_position().y,mini_tiles.ENEMY)
