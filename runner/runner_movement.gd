extends Node3D

# the floor is 12 on each side, not 12 in total
const LEFT_LANE = -6
const MIDDLE_LANE = 0
const RIGHT_LANE = 6

@export var current_speed = 30.0
@export var speed_increase = 0.5
@export var rate_of_speed_increase = 0.1
@export var distance_threshold = 0

var current_distance_ran = 0

func _ready():
	pass

func handle_speed(delta):
	if position.z / 500 > 0:
		distance_threshold += 1
		current_speed -= (current_speed + speed_increase)
		rate_of_speed_increase = distance_threshold * 0.1
		speed_increase += rate_of_speed_increase
		current_speed += speed_increase
		position.z -= current_speed * delta

	else:
		position.z -= current_speed * delta

func _process(delta):
	handle_speed(delta)

	if Input.is_action_just_pressed("move_left"):
		if position.x == RIGHT_LANE:
			position.x = MIDDLE_LANE
		else:
			position.x = LEFT_LANE
		
	if Input.is_action_just_pressed("move_right"):
		if position.x == LEFT_LANE:
			position.x = MIDDLE_LANE
		else:
			position.x = RIGHT_LANE
