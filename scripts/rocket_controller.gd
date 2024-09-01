extends Node3D
class_name RocketController

@export var controlled_body: RigidBody3D
const THRUST_FORCE: float = 3.0

@export var engine_timer: Timer
@export var explosion_timer: Timer

@onready var engine_emitter: GPUParticles3D = $"../ThrustEmitter"
@onready var trail_emitter: GPUParticles3D = $"../TrailEmitter"
@onready var explosion_emitter: GPUParticles3D = $"../ExplosionEmitter"

var engine_on: bool = true

func _ready() -> void:
	engine_timer.timeout.connect(_disable_engine)
	explosion_timer.timeout.connect(_explode)
	controlled_body.body_entered.connect(func (body: Node) -> void:
		_explode()
	)
	
func _physics_process(delta: float) -> void:
	_apply_forces()
	
func _apply_forces() -> void:
	if engine_on:
		var forward := -global_transform.basis.z
		controlled_body.apply_central_force(forward * THRUST_FORCE)
	
func _disable_engine() -> void:
	engine_on = false
	engine_emitter.emitting = false

func _explode() -> void:
	_disable_engine()
	#$"../CollisionShape3D".disabled = true
	$"../MeshInstance3D".visible = false
	controlled_body.collision_mask = 0
	explosion_emitter.emitting = true
	trail_emitter.emitting = false
	await explosion_emitter.finished
	controlled_body.queue_free()
