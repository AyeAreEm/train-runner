extends Node

var test_preset = preload("res://test levels/test_preset.tscn")
@onready var runner = $runner

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_3d_body_entered(body):
	if body.get_parent().name == "runner":
		var next_preset = test_preset.instantiate()
		next_preset.position.z = -320.0
		add_child(next_preset)
