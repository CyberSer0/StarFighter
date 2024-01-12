extends Node2D

@export var strafing_direction : int = 0
@export var strafing_particles_right : GPUParticles2D
@export var strafing_particles_left : GPUParticles2D

func _physics_process(delta):
	if strafing_direction < 0:
		strafing_particles_left.emitting = true
		strafing_particles_right.emitting = false
	elif strafing_direction > 0:
		strafing_particles_left.emitting = false
		strafing_particles_right.emitting = true
	else:
		strafing_particles_right.emitting = false
		strafing_particles_left.emitting = false
