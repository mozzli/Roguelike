extends Control

class_name BattleArena

var start_resolution = Vector2(40,40)
var max_resolution
var resolution
var transition_on = false
var window_opening_speed_x = 10
var window_opening_speed_y = 10
var trasition_ready = false
var show_background
var all_units = []
var current_turn_unit: BaseBattleUnit
var main_player
var main_enemy
var battle_end = false
var player_won: bool
onready var battlePanel = $BackgroundPlains/Plains/BattlePanel
onready var music = get_parent().get_node("Audio")

signal units_done
signal pause_off

var player_units = {BattleEnums.BattleRows.FIRST_BACK: null,
	BattleEnums.BattleRows.FIRST_FRONT: null,
	BattleEnums.BattleRows.SECOND_BACK: null,
	BattleEnums.BattleRows.SECOND_FRONT: null,
	BattleEnums.BattleRows.THIRD_BACK: null,
	BattleEnums.BattleRows.THIRD_FRONT: null}

var enemy_units = {BattleEnums.BattleRows.FIRST_BACK: null,
	BattleEnums.BattleRows.FIRST_FRONT: null,
	BattleEnums.BattleRows.SECOND_BACK: null,
	BattleEnums.BattleRows.SECOND_FRONT: null,
	BattleEnums.BattleRows.THIRD_BACK: null,
	BattleEnums.BattleRows.THIRD_FRONT: null}

func _ready():
	$BattleFadeOut/ColorRect.rect_size = get_viewport_rect().size
	max_resolution = get_viewport_rect().size
	rect_size = start_resolution

func _process(delta):
	if get_tree().paused == false:
		emit_signal("pause_off")

func prepare_battle(player, enemy, _terrain):
	music.change_music(music.get_audio(music.audio.BATTLE_NORMAL))
	battlePanel.reset_pictures()
	battlePanel.reset_battle_text()
	main_player = player
	main_enemy = enemy
	prepare_enemies_position(enemy)
	prepare_players_position(main_player)
	battlePanel.refresh_units_hp(player_units, enemy_units)
	refresh_unit_list()
	battlePanel.prepare_enemy_pics(enemy_units)
	battlePanel.prepare_player_pics(player_units)
	reset_units_ticks()
	show_forest()
	yield($BattleFadeOut/ColorRect/AnimationPlayer, "animation_finished")
	next_turn()

func prepare_enemies_position(enemy):
	enemy_units = enemy.get_party()

func prepare_players_position(player):
	player_units = player.get_party()

func show_forest():
	GameVariables.gui_is_on = true
	GameVariables.battle_on = true
	transition_process()
	yield($BattleFadeOut/ColorRect/AnimationPlayer, "animation_finished")
	$BattleFadeOut/ColorRect.material.set_shader_param("cutoff",1)
	popup_plains()

func end_battle() -> void:
	battlePanel.show_exit_button()
	if !player_won:
		battlePanel.add_battle_text("The party has lost")
	elif player_won:
		var money = main_enemy.get_reward_money()
		var items = main_enemy.get_reward_items()
		battlePanel.add_battle_text("Party gains " + String(money) + " money!")
		print(items)
		for item in items:
			battlePanel.add_battle_text("Party gets "+ String(GlobalItems.get_item_name(item)) + "!")

func transition_process():
	$BattleFadeOut.play_shader()
	transition_on = false
	
func popup_plains():
	get_parent().get_node("Camera2D").zoom_out_camera()
	$BackgroundPlains.popup()
	$BackgroundPlains.rect_position = get_node("../Camera2D").get_camera_edge()
	$BackgroundPlains/Plains/ColorRect.rect_size = get_viewport_rect().size

func refresh_unit_list():
	all_units.clear()
	current_turn_unit = null
	battle_end = false
	for i in player_units:
		if player_units[i] != null:
			all_units.append(player_units[i])
	for i in enemy_units:
		if enemy_units[i] != null:
			all_units.append(enemy_units[i])

func reset_units_ticks() -> void:
	for unit in all_units:
		unit.reset_ticks()

func get_next_unit():
	var min_unit = null
	for unit in all_units:
		if unit.get_if_alive():
			if min_unit == null:
				min_unit = unit
			elif min_unit.get_next_tick_value() > unit.get_next_tick_value():
				min_unit = unit
	min_unit.set_next_tick_value()
	return min_unit

func get_active_player_units() -> Array:
	var active_units = []
	for unit in player_units:
		var player = player_units.get(unit)
		if player != null:
			if player.get_if_alive():
				active_units.append(player)
	return active_units

func get_active_enemy_units() -> Array:
	var active_units = []
	for unit in enemy_units:
		var enemy = enemy_units.get(unit)
		if enemy != null:
			if enemy.get_if_alive():
				active_units.append(enemy)
	return active_units

func next_turn() -> void:
	if get_tree().paused == true:
		yield(self, "pause_off")
	if current_turn_unit != null:
		battlePanel.change_selected_unit(current_turn_unit)
	current_turn_unit = get_next_unit()
	battlePanel.change_selected_unit(current_turn_unit)
	battlePanel.set_selected_unit_portrait(current_turn_unit)
	battlePanel.add_battle_text("It's " +(String(current_turn_unit.get_unit_name())) + "'s turn")
	unit_action(current_turn_unit)
	if current_turn_unit.get_unit_type() == "player":
		yield(self, "units_done")
	yield(get_tree().create_timer(2.0), "timeout")
	check_if_end()
	if battle_end:
		battlePanel.change_selected_unit(current_turn_unit)
		end_battle()
	else:
		next_turn()
	
func unit_action(unit) -> void:
	if unit.get_unit_type() == "enemy":
		yield(get_tree().create_timer(2.0), "timeout")
		enemy_attack(current_turn_unit)
	elif unit.get_unit_type() == "player":
		battlePanel.show_player_gui_buttons()
		yield(get_tree().create_timer(2.0), "timeout")
		player_action(current_turn_unit)

func check_if_end():
	if get_active_player_units().empty():
		battle_end = true
		player_won = false
	elif get_active_enemy_units().empty():
		battle_end = true
		player_won = true

func player_action(player_unit: BaseBattleUnit) -> void:
	yield($BackgroundPlains/Plains/BattlePanel, "player_attacked")

func enemy_attack(enemy_unit: BaseBattleUnit):
	var attack_damage = enemy_unit.use_random_attack()
	var players = get_active_player_units()
	var chosen_unit = players[Utilities.rng.randi_range(0, players.size() -1)]
	chosen_unit.lower_stat(attack_damage, StatEnums.stat_enums.CURRENT_HP)
	battlePanel.add_battle_text(String(enemy_unit.get_unit_name()) + " attacked " + String(chosen_unit.get_unit_name()) + " for " + String(attack_damage) + " damage!")
	battlePanel.refresh_units_hp(player_units, enemy_units)

func player_attack(player_attack, enemy_unit: int, player_unit: BaseBattleUnit):
	var attack_damage = Attacks.get_damage(player_attack,player_unit)
	var enemy = enemy_units[enemy_unit]
	enemy.lower_stat(attack_damage, StatEnums.stat_enums.CURRENT_HP)
	battlePanel.add_battle_text(String(player_unit.get_unit_name()) + " attacked " + String(enemy.get_unit_name()) + " for " + String(attack_damage) + " damage!")
	battlePanel.refresh_units_hp(player_units,enemy_units)
	emit_signal("units_done")
	battlePanel.hide_player_gui_buttons()

func get_enemy_party() -> Dictionary:
	return enemy_units

func _on_BattlePanel_close_arena():
	music.fade_music_in(music.get_audio(music.audio.FOREST_MAZE))
	transition_process()
	yield($BattleFadeOut/ColorRect/AnimationPlayer, "animation_finished")
	yield(get_tree().create_timer(0.5), "timeout")
	$BattleFadeOut/ColorRect.material.set_shader_param("cutoff",1)
	battlePanel.hide_exit_button()
	if !player_won:
		main_player.delete_unit()
	elif player_won:
		main_enemy.delete_unit()
	GameVariables.gui_is_on = false
	GameVariables.battle_on = false
	$BackgroundPlains.hide()
