extends Area2D

var object_body
var column
var row

func _ready():
	column = MovementUtils.map.world_to_map(global_position).x
	row = MovementUtils.map.world_to_map(global_position).y
	

func _on_TreasureChest_body_entered(body):
	GameVariables.object_under_player = self
	object_body = body

func _on_TreasureChest_body_exited(_body):
	GameVariables.object_under_player = null
	object_body = null

func play_event():
	var current_map = GameVariables.current_map
	var item_get = ItemsList.get_random_item_lvl1()
	var item_acquired = ItemsList.get_item_name(item_get)
	object_body.get_node("Equipment").equipment.append(item_get)
	current_map.get_node("TreasureControl").open_treasure_event(item_acquired)
	self.queue_free()

func _process(delta):
	if GameVariables.current_map.get_node("FogOfWar").check_if_visible(column, row) == true:
		visible = true
	else:
		visible = false
