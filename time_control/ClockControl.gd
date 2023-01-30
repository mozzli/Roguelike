extends Control

class_name ClockControl

var hand_texture = load("res://images/clock/hand.png")
var rotation_degree = 0
var current_rotation = 0

func _ready():
	rotate_hand()

func _process(_delta):
	if current_rotation == 360:
		reset_clock()
	if current_rotation < rotation_degree:
		current_rotation += 0.5
		rotate_hand()

func rotate_hand():
	$Hand.rect_rotation += 0.5

func reset_clock():
	rotation_degree = 0
	current_rotation = 0
	$Hand.rect_rotation = 0

func add_time():
	rotation_degree += 30
