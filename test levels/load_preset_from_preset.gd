extends Node3D

# this file is used only to tell the main scene to load a new preset
func _on_area_3d_body_entered(body):
	if body.get_parent().name == "runner":
		get_tree().get_root().get_child(0).load_random_preset()
