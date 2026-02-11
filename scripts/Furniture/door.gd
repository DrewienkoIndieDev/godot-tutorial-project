extends Node3D

@onready var animation_player: AnimationPlayer = $door/AnimationPlayer

var opened = false

func interact():
	if not animation_player:
		return
	
	if !opened:
		open_door()

	elif opened:
		close_door()

	opened = !opened

func open_door():
	print("Opening door")
	animation_player.play("Animation")
	
func close_door():
	print("Closing door")
	animation_player.play_backwards("Animation")
