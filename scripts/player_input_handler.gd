extends Node3D

@export var ship: ShipController
@export var rocket: RocketSpawner

@export_enum("p1_", "p2_") var prefix: String = "p1_"

func _process(delta: float) -> void:
	ship.in_acceleration = Input.get_axis(prefix + "down", prefix + "up")
	ship.in_rotation = Input.get_axis(prefix + "right", prefix + "left")
	
	if Input.is_action_just_pressed(prefix + "fire"):
		rocket.fire()
