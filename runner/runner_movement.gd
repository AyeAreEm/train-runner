extends CharacterBody3D

const LEFT_LANE = -6.0
const MIDDLE_LANE = 0.0
const RIGHT_LANE = 6.0

@export var gravity = 10.0
@export var jump_velocity = 1000.0

@export var distance_threshold = 50
@export var speed = 15.0

var distance_threshold_count = 0
var target_position = position

func _ready():
	pass
	#velocity = Vector3(0, 0, 1)

func handle_speed(delta):
	if round(abs(position.z)) as int % distance_threshold == 0:
		speed += 0.2
		print(speed)
		target_position.z -= speed * delta
	else:
		target_position.z -= speed * delta

func handle_jump(delta):
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y += jump_velocity * delta
	if not is_on_floor():
		velocity.y -= gravity * delta

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

	position = lerp(position, target_position, 0.1)

	move_and_slide()
