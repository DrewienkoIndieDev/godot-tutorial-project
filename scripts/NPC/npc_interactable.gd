extends Interactable

@export var object_name: String

func interact() -> void:
	DialogicManager.start_dialogue("intro", "locked")


func get_interact_prompt() -> String:
	return "Press E to interact with %s" %object_name
