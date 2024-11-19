extends Node

@onready var runner = $runner

var preset1 = preload("res://test levels/demo_preset_1.tscn")
var preset2 = preload("res://test levels/demo_preset_2.tscn")
var presets = [preset1, preset2]

var loaded_presets = []

var rng = RandomNumberGenerator.new()

var append_preset_position = 0

func load_random_preset():
	var preset = presets[rng.randi_range(0, 1)].instantiate()
	print(preset.get_meta("scene_length"))
	
	append_preset_position -= preset.get_meta("scene_length")
	preset.position.z = append_preset_position
	add_child(preset)
	
	if len(loaded_presets) > 1:
		var old_preset = loaded_presets.pop_front()
		old_preset.queue_free()
	
	loaded_presets.push_back(preset)

func _on_area_3d_body_entered(body):
	if body.get_parent().name == "runner":
		load_random_preset()
