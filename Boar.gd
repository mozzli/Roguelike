extends Area2D

var type = "enemy"
var movement_on = false
var movement_amount = 2
var movement_next_tile
var movement_goal_position
signal boar_is_on_goal
signal boar_was_moved

func _process(delta):
	if movement_on && movement_goal_position != global_position:
		if global_position.x > movement_goal_position.x:
			global_position.x -= 0.5
		elif global_position.x < movement_goal_position.x:
			global_position.x += 0.5
		if global_position.y > movement_goal_position.y:
			global_position.y -= 1
		elif global_position.y < movement_goal_position.y:
			global_position.y += 1
	if global_position == movement_goal_position && movement_on == true:
		movement_on = false
		emit_signal("boar_is_on_goal")

func enemy_turn():
	for i in range(0,movement_amount):
		move_boar()
		yield(self, "boar_is_on_goal")
	emit_signal("boar_was_moved")

func move_boar():
	movement_next_tile = EnemyMovement.boar_movement_tile(self)
	movement_goal_position = MovementUtils.get_cell_in_position(movement_next_tile, MovementUtils.map.world_to_map(self.global_position))
	movement_goal_position = MovementUtils.map.map_to_world(Vector2(movement_goal_position[0], movement_goal_position[1])) + Vector2(32,24)
	movement_on = true
	

func play_event():
	print("BOAR FIGHT!")

func _on_Boar_body_entered(body):
	GameVariables.object_under_player = self

func boar_moved():
	print("it works!")
	yield(self, "boar_was_moved")
