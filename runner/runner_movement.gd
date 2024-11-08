extends CharacterBody3D

const LEFT_LANE = -6.0
const MIDDLE_LANE = 0.0
const RIGHT_LANE = 6.0

@export var jump_height = 5.0
@export var jump_time_apex = 0.5
@export var jump_time_fall = 0.5

@onready var jump_velocity = (2.0 * jump_height) / jump_time_apex
@onready var jump_gravity = (-2.0 * jump_height) / (jump_time_apex * jump_time_apex)
@onready var fall_gravity = (-2.0 * jump_height) / (jump_time_fall * jump_time_fall)

@export var distance_threshold = 50
@export var speed = 15.0

var distance_threshold_count = 0
var target_position = position

func _ready():
	pass

func handle_speed(delta):
	if round(abs(position.z)) as int % distance_threshold == 0:
		speed += 0.2
		target_position.z -= speed * delta
	else:
		target_position.z -= speed * delta

func handle_jump(delta):
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	if not is_on_floor():
		velocity.y += get_gravity() * delta
		
func get_gravity() -> float:
	return jump_gravity if velocity.y > 0.0 else fall_gravity

func _process(delta):
	handle_speed(delta)
	handle_jump(delta)
	
	if Input.is_action_pressed("move_left"):
		if round(position.x) == RIGHT_LANE:
			target_position.x = MIDDLE_LANE
		elif round(position.x) == MIDDLE_LANE:
			target_position.x = LEFT_LANE
		else:
			target_position.x = target_position.x

	if Input.is_action_pressed("move_right"):
		if round(position.x) == LEFT_LANE:
			target_position.x = MIDDLE_LANE
		elif round(position.x) == MIDDLE_LANE:
			target_position.x = RIGHT_LANE
		else:
			target_position.x = target_position.x

	position.x = lerp(position.x, target_position.x, 0.1)
	position.z = lerp(position.z, target_position.z, 0.1)

	move_and_slide()
