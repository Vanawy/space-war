extends Node2D

@export var from: RigidBody3D
@export var to: Node2D
@export var viewport: SubViewport
@export var view_camera: Camera3D

var prediction_offset: float = 0.5

@export var point1: Node2D
@export var point2: Node2D

func _physics_process(delta: float) -> void:
	
	var pos := view_camera.unproject_position(from.position) * viewport.get_screen_transform()
	to.global_position = pos
	
	var predicted_pos_1 := from.position + from.linear_velocity * prediction_offset
	var predicted_pos_2 := from.position + from.linear_velocity * prediction_offset * 2
	point1.global_position = view_camera.unproject_position(predicted_pos_1) * viewport.get_screen_transform()
	point2.global_position = view_camera.unproject_position(predicted_pos_2) * viewport.get_screen_transform()
	
