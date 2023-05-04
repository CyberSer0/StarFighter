extends GPUParticles2D

@export var engine_mode : int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if engine_mode == 0:
		emitting = false
	else: 
		emitting = true
#	match(engine_mode):
#		0:
#			emitting = false
#		1:
#			amount = 16
#			emitting = true
#		2:
#			amount = 32
#			emitting = true
#		3:
#			amount = 64
#			emitting = true
		
