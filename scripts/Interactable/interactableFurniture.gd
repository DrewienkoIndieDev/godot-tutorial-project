extends Interactable
class_name InteractableFurniture

@export var animation_name: String
@export var animation_path: NodePath
@export var furniture_name: String


@onready var animation_player: AnimationPlayer = get_node(animation_path)

var opened := false

func _ready() -> void:
	if opened:
		play_open()
	else:
		return

func interact():
	print("Interacting with furniture")
	if not animation_player:
		return
	
	if !opened:
		play_open()
	else:
		play_close()

func play_open():
	animation_player.play(animation_name)
	opened = true
	interaction_state_changed.emit()
	
func play_close():
	animation_player.play_backwards(animation_name)
	opened = false
	interaction_state_changed.emit()
	
func get_interact_prompt() -> String:
	if opened:
		return "Press E to to close the %s" % furniture_name
	else:
		return "Press E to to open the %s" % furniture_name
