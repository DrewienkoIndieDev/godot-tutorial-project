extends MeshInstance3D

@onready var dummy_cam: Node3D = $DummyCam
@onready var mirror_cam: Camera3D = $SubViewport/MirrorCam
@onready var sub_viewport: SubViewport = $SubViewport
@onready var root := get_tree().root


func _ready() -> void:
	add_to_group("mirrors")
	update_view_size()
	root.size_changed.connect(update_view_size)

func update_view_size():
	sub_viewport.size = root.size

func update_cam(main_cam: Camera3D):
	scale.y *= -1
	
	dummy_cam.global_transform = main_cam.global_transform
	
	scale.y *= -1
	
	mirror_cam.global_transform = dummy_cam.global_transform
	
	var t := mirror_cam.global_transform
	t.basis.x *= -1
	mirror_cam.global_transform = t
	
	mirror_cam.fov = main_cam.fov
