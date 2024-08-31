extends Node3D
class_name ShipController

@export var controlled_body: RigidBody3D

var in_acceleration: float = 0.0
var in_rotation: float = 0.0

const THRUST_FORCE: float = 3.0
const RCS_FORCE: float = 0.2
	
func _physics_process(delta: float) -> void:
	var forward := -global_transform.basis.z
	controlled_body.apply_central_force(forward * THRUST_FORCE * in_acceleration)
	controlled_body.apply_torque(Vector3.UP * RCS_FORCE * in_rotation)
	
	if abs(in_rotation) < 0.01:
		if abs(controlled_body.angular_velocity.y) > 0.1:
			controlled_body.apply_torque(Vector3.UP * sign(controlled_body.angular_velocity.y) * -RCS_FORCE)
