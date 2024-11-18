extends Node

@onready var runner = $runner

var preset1 = preload("res://test levels/demo_preset_1.tscn")
var preset2 = preload("res://test levels/demo_preset_2.tscn")
var presets = [preset1, preset2]

var rng = RandomNumberGenerator.new()

const FLOOR_LENGTH = -320.0
var floors_count = 1

func load_random_preset():
	print("loading random preset")
	print(floors_count * FLOOR_LENGTH)
	var preset = presets[rng.randi_range(0, 1)].instantiate()
	preset.position.z = FLOOR_LENGTH * floors_count
	add_child(preset)
	
	floors_count += 1

func _on_area_3d_body_entered(body):
	if body.get_parent().name == "runner":
		load_random_preset()
