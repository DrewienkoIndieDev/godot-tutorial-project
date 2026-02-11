extends Node3D
class_name RoofLamp

@onready var omni_light_3d: OmniLight3D = $OmniLight3D
var is_on := true

func _ready():
	is_on = omni_light_3d.visible
	
func turn_on():
	omni_light_3d.visible = true
	is_on = true

func turn_off():
	omni_light_3d.visible = false
	is_on = false
	
func toggle():
	if is_on:
		turn_off()
	else:
		turn_on()
