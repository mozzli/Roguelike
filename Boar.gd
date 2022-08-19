extends Area2D

var type = "enemy"
var movement_on = false
var movement_amount = 3
var x_speed = 1.3
var y_speed = 2
var movement_next_tile
var movement_goal_position = Vector2(1,1)
var column
var row

signal boar_is_on_goal
signal boar_was_moved


func _ready():
	$PartyNode.get_random_party()
	print($PartyNode.party)

func _process(_delta):
	column = MovementUtils.map.world_to_map(global_position).x
	row = MovementUtils.map.world_to_map(global_position).y
	var gp = global_position
	var mgp = movement_goal_position
	if movement_on && mgp != gp:
		set_x_speed()
		set_body_position()
	if gp.x >= mgp.x - 2 && gp.x <= mgp.x + 2 && gp.y >= mgp.y - 2 && gp.y <= mgp.y + 2 && movement_on == true:
		goal_achived()
	if GameVariables.current_map.get_node("FogOfWar").check_if_visible(column, row) == true:
		visible = true
	else:
		visible = false

func enemy_turn():
	$WalkingSound.play(0.0)
	for _i in range(0,movement_amount):
		move_boar()
		yield(self, "boar_is_on_goal")
	emit_signal("boar_was_moved")
	$WalkingSound.stop()

func move_boar():
	movement_next_tile = EnemyMovement.boar_movement_tile(self)
	movement_goal_position = MovementUtils.get_cell_in_position(movement_next_tile, MovementUtils.map.world_to_map(self.global_position))
	movement_goal_position = MovementUtils.map.map_to_world(Vector2(movement_goal_position[0], movement_goal_position[1])) + Vector2(32,24)
	movement_on = true

func play_event():
	print("BOAR FIGHT!")

func _on_Boar_body_entered(_body):
	play_event()

func set_x_speed():
	if !global_position.y >= movement_goal_position.y + 2 && !global_position.y <= movement_goal_position.y-2:
		x_speed = 2.2
	else:
		x_speed = 1.3

func set_body_position():
	if global_position.x > movement_goal_position.x+2:
		global_position.x -= x_speed
	elif global_position.x < movement_goal_position.x-2:
		global_position.x += x_speed
	if global_position.y >= movement_goal_position.y + 2:
		global_position.y -= y_speed
	elif global_position.y <= movement_goal_position.y-2:
		global_position.y += y_speed

func goal_achived():
		movement_on = false
		emit_signal("boar_is_on_goal")
