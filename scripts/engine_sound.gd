extends AudioStreamPlayer3D

@export var emitter: GPUParticles3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stream_paused = true
	play(randf() * 5)

func _process(delta: float) -> void:
	stream_paused = not emitter.emitting
