extends Area2D

var object_body
var column
var row

func _ready():
	column = MovementUtils.map.world_to_map(global_position).x
	row = MovementUtils.map.world_to_map(global_position).y
	

func _on_TreasureChest_body_entered(body):
	play_event(body)

func _on_TreasureChest_body_exited(_body):
	GameVariables.object_under_player = null
	object_body = null

func play_event(body):
	var current_map = GameVariables.current_map
	var item_get = GlobalItems.get_random_item_lvl1()
	var item_acquired = GlobalItems.get_item_name(item_get)
	body.get_item(item_get)
	current_map.get_node("TreasureControl").open_treasure_event(item_acquired)
	self.queue_free()

func _process(_delta):
	if GameVariables.current_map.get_node("FogOfWar").check_if_visible(column, row) == true:
		visible = true
	else:
		visible = false
