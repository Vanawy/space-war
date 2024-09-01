extends Node3D
class_name ShipController

@export var controlled_body: RigidBody3D

var in_acceleration: float = 0.0
var in_rotation: float = 0.0

const THRUST_FORCE: float = 3.0
const BACKWARDS_FORCE: float = 1.0
const RCS_FORCE: float = 0.2

var active_rcs_force: float = 0
var active_thrust_force: float = 0

@export var forwards_emitter: GPUParticles3D
@export var backwards_emitter: GPUParticles3D
@export var rcs_cw_emitter: GPUParticles3D
@export var rcs_ccw_emitter: GPUParticles3D
@export var explosion_emotter: GPUParticles3D

var is_dead: bool = false

signal died

func _ready() -> void:
	controlled_body.body_entered.connect(func(body: Node) -> void:
		_explode()
	)
	
func _physics_process(delta: float) -> void:
	_apply_forces()
	_update_emitters()
	
func _explode() -> void:
	if is_dead:
		return
	explosion_emotter.emitting = true
	is_dead = true
	died.emit()
	await explosion_emotter.finished
	
func _apply_forces() -> void:
	var forward := -global_transform.basis.z
	if in_acceleration > 0:
		active_thrust_force = THRUST_FORCE * in_acceleration
	elif in_acceleration < 0:
		active_thrust_force = BACKWARDS_FORCE * in_acceleration
	else:
		active_thrust_force = 0
		
	
	active_rcs_force = RCS_FORCE * in_rotation
	if abs(in_rotation) < 0.01:
		if abs(controlled_body.angular_velocity.y) > 0.1:
			active_rcs_force = sign(controlled_body.angular_velocity.y) * -RCS_FORCE
	if not is_dead:
		controlled_body.apply_central_force(forward * active_thrust_force)
		controlled_body.apply_torque(Vector3.UP * active_rcs_force)
	
	
	
func _update_emitters() -> void:
	backwards_emitter.emitting = false
	forwards_emitter.emitting = false
	rcs_ccw_emitter.emitting = false
	rcs_cw_emitter.emitting = false
	
	if is_dead:
		return
		
	if active_thrust_force > 0.1:
		forwards_emitter.emitting = true
	elif active_thrust_force < -0.1:
		backwards_emitter.emitting = true
	
	if active_rcs_force > 0.1:
		rcs_ccw_emitter.emitting = true
	elif active_rcs_force < -0.1:
		rcs_cw_emitter.emitting = true
