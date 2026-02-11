extends Interactable
class_name  LampSwitchInteractable

@export var lamp_path: NodePath
@onready var lamp: RoofLamp = get_node(lamp_path)
@onready var animation_player: AnimationPlayer = $LightSwitch/AnimationPlayer

func _ready():
	if lamp.is_on:
		force_switch_on()


func interact():
	if not lamp or not animation_player:
		return
	
	if lamp.is_on:
		turn_off()
	else:
		turn_on()

func turn_on():
	animation_player.play("SwitchAction")
	lamp.toggle()
	interaction_state_changed.emit()


func turn_off():
	animation_player.play_backwards("SwitchAction")
	lamp.toggle()
	interaction_state_changed.emit()


func force_switch_on():
	animation_player.set_current_animation("SwitchAction")
	animation_player.seek(animation_player.current_animation_length, true)
	animation_player.advance(0.0)


func get_interact_prompt() -> String:
	if lamp and lamp.is_on:
		return "Press E to turn off the light"
	else:
		return "Press E to turn on the light"
