extends Camera3D

func _process(delta):
	get_tree().call_group("mirrors", "update_cam", self)
