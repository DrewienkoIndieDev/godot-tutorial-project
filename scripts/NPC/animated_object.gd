extends CharacterBody3D

@export var animation_path: NodePath
@onready var animation_player: AnimationPlayer = get_node(animation_path)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()


func _ready() -> void:
	var animation := animation_player.get_animation("ArmatureAction")
	animation.loop = true
	animation_player.play("ArmatureAction")
