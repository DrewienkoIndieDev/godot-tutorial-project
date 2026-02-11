extends Node3D
class_name Interactable

@export var interact_text := "Press E to interact"

@warning_ignore("unused_signal")
signal interaction_state_changed


func interact() -> void:
	pass


func get_interact_prompt() -> String:
	return interact_text
