extends Node3D

@export var ship: ShipController

func _process(delta: float) -> void:
	ship.in_acceleration = Input.get_axis("ui_down", "ui_up")
	ship.in_rotation = Input.get_axis("ui_right", "ui_left")
