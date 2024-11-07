extends CharacterBody3D

const LEFT_LANE = -6.0
const MIDDLE_LANE = 0.0
const RIGHT_LANE = 6.0

@export var gravity = 1.0
@export var jump_velocity = 200.0
@export var current_speed = 30.0
@export var speed_increase = 0.5
@export var rate_of_speed_increase = 0.1
@export var distance_threshold = 0

var current_distance_ran = 0
var target_position = position  # Initialize target position

func _ready():
	velocity = Vector3(0,0,1)
	
func handle_speed(delta):
	if position.z / 500 > 0:
		distance_threshold += 1
		current_speed -= (current_speed + speed_increase)
		rate_of_speed_increase = distance_threshold * 0.1
		speed_increase += rate_of_speed_increase
		current_speed += speed_increase
		velocity.z -= current_speed * delta 
	else:
		velocity.z -= current_speed * delta

func handle_jump(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_velocity * delta
	if not is_on_floor():
		velocity.y -= gravity * delta
	

func _process(delta):
	handle_speed(delta)
	handle_jump(delta)
	
	print(velocity)
	print()
	# Determine target position based on input
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

	# Smoothly move towards the target position
	position.x = lerp(position.x, target_position.x, 0.1)  # Adjust 0.1 for smoothness'

	move_and_slide()
