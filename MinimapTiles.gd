extends Node2D

onready var main_map: TileMap = MovementUtils.map
onready var fog_map: TileMap = MovementUtils.fog_map

func update_minimap():
	for row in range(-1,GameVariables.map_rows+1):
		for column in range(-1,GameVariables.map_columns+1):
			$Map.set_cell(row, column, MovementUtils.map.get_cell(row,column))
			$FogOfWar.set_cell(row, column, MovementUtils.fog_map.get_cell(row,column))
