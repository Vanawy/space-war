extends Node3D
class_name RocketSpawner

var rocket_ready: bool = true

@export var cooldown_timer: Timer

var rocket_preload: PackedScene = preload("res://scenes/rocket.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cooldown_timer.timeout.connect(func() -> void:
		rocket_ready = true
	)

func fire() -> bool:
	if not rocket_ready:
		return false
	_spawn_rocket()
	cooldown_timer.start()
	rocket_ready = false
	return true

func _spawn_rocket() -> void:
	
	var parent: Node3D = get_parent();
	var rocket: RigidBody3D = rocket_preload.instantiate()
	rocket.position = parent.get_parent().to_local(global_position)
	rocket.rotation = parent.rotation
	rocket.apply_central_impulse(-global_transform.basis.z * 10)
	parent.add_sibling(rocket)
