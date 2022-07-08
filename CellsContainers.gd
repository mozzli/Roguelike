extends Node

var cellsContainers = {}

func create_cells_containers():
	for row in range(GameVariables.map_rows):
		for column in range(GameVariables.map_columns):
			cellsContainers[[row,column]] = null

func _ready():
	create_cells_containers()

func set_cell_container(row, column, value):
	cellsContainers[[row,column]] = value
