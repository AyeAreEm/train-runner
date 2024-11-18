extends Node3D

func _on_area_3d_body_entered(body):
	if body.get_parent().name == "runner":
		get_tree().get_root().get_child(0).load_random_preset()
