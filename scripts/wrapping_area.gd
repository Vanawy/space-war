extends Area3D

func _ready() -> void:
	body_exited.connect(_wrap)


func _wrap(body: Node3D) -> void:
	body.global_position = body.global_position * Vector3(-1, 0, -1)
