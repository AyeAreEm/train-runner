extends Node

@onready var runner = $runner

var preset1 = preload("res://test levels/demo_preset_1.tscn")
var preset2 = preload("res://test levels/demo_preset_2.tscn")
var presets = [preset1, preset2]

var loaded_presets = []

var rng = RandomNumberGenerator.new()

const FLOOR_LENGTH = -320.0
var floors_count = 1

func load_random_preset():
	print(loaded_presets)
	var preset = presets[rng.randi_range(0, 1)].instantiate()
	preset.position.z = FLOOR_LENGTH * floors_count
	add_child(preset)
	
	if len(loaded_presets) > 1:
		var old_preset = loaded_presets.pop_front()
		old_preset.queue_free()
	
	loaded_presets.push_back(preset)
	floors_count += 1

func _on_area_3d_body_entered(body):
	if body.get_parent().name == "runner":
		load_random_preset()
