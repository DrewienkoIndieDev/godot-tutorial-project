extends WorldEnvironment

@export var sun: DirectionalLight3D
@export var moon_light: DirectionalLight3D
@export var moon_pivot: Node3D

@export var env_day: Environment
@export var env_night: Environment

@export var cloud_scene: PackedScene
@export var clouds_pivot: Node3D

var min_sun_energy := 0.0
var max_sun_energy := 1.0
var min_moon_energy := 0.0
var max_moon_energy := 0.05

var cloud_count := 50
var cloud_speed := 10.0
var cloud_spawn_x := 600.0
var cloud_end_x := -600.0
var cloud_min_height := 150.0
var cloud_max_height := 300.0
var cloud_min_z := -600.0
var cloud_max_z := 600.0

# 0 -> 1 (0.0 = sunrise, 0.25 = noon, 0.5 = sunset, 0.75 = midnight)
var time_of_day := 0.5
var day_lenght_seconds := 20

func _ready() -> void:
	apply_time_to_sun()
	update_night_sky()
	spawn_clouds()


func _process(delta: float) -> void:
	update_rotation(delta)
	update_sun_and_moon_energy(delta)
	update_night_sky()
	update_clouds(delta)


func is_night() -> bool:
	return time_of_day > 0.5


func apply_time_to_sun():
	var angle = time_of_day * TAU - PI
	
	sun.rotation.x = angle
	
	moon_pivot.rotation.x = angle + PI
	moon_light.global_rotation = moon_pivot.global_rotation


func update_rotation(delta):
	time_of_day = fmod(time_of_day + (delta / day_lenght_seconds), 1.0)
	apply_time_to_sun()


func update_sun_and_moon_energy(delta):
	if is_night():
		sun.light_energy = lerp(sun.light_energy, min_sun_energy, delta * 2.0)
		moon_light.light_energy = lerp(moon_light.light_energy, max_moon_energy, delta * 2.0)
	else:
		sun.light_energy = lerp(sun.light_energy, max_sun_energy, delta * 2.0)
		moon_light.light_energy = lerp(moon_light.light_energy, min_moon_energy, delta * 2.0)


func update_night_sky():
	if is_night() and environment != env_night:
		environment = env_night
	elif not is_night() and environment != env_day:
		environment = env_day


func spawn_clouds():
	if not cloud_scene or not clouds_pivot:
		return
	
	for i in range(cloud_count):
		var cloud_instance = cloud_scene.instantiate()
		
		cloud_instance.position = Vector3(
			randf_range(cloud_end_x, cloud_spawn_x),
			randf_range(cloud_min_height, cloud_max_height),
			randf_range(cloud_min_z, cloud_max_z)
		)
		
		cloud_instance.scale = Vector3(
			randf_range(0.5, 2.0),
			randf_range(0.3, 1.5),
			randf_range(0.5, 2.0),
		)
		
		clouds_pivot.add_child(cloud_instance)

func update_clouds(delta):
	for cloud in clouds_pivot.get_children():
		cloud.translate(Vector3(-cloud_speed * delta, 0, 0))
		
		if cloud.global_position.x < cloud_end_x:
			cloud.global_position = Vector3(
			cloud_spawn_x,
			randf_range(cloud_min_height, cloud_max_height),
			randf_range(cloud_min_z, cloud_max_z)
		)
