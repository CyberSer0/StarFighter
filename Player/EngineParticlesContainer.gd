extends Node2D

@export var player_direction : int = 0
@export var engine_particles_fwd : GPUParticles2D
@export var engine_particles_bwd : GPUParticles2D

func _physics_process(delta):
	if player_direction > 0:
		engine_particles_bwd.emitting = true
		engine_particles_fwd.emitting = false
	elif player_direction < 0:
		engine_particles_bwd.emitting = false
		engine_particles_fwd.emitting = true
	else:
		engine_particles_fwd.emitting = false
		engine_particles_bwd.emitting = false
