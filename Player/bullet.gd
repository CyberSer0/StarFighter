extends StaticBody2D


@export var speed : float = 200.0
@export var lifetime : float = 1.0

@export var direction : Vector2 :
	set(value):
		rotation = value.angle()
		#print("[   ] Set bullet direction to ", direction)
		direction = value
@export var degradation_value : float = 1


func _ready():
	#print("[   ] Bullet created")
	$Timer.start(lifetime)


func _process(delta):
	degradation_value = $Timer.time_left / $Timer.wait_time
	if degradation_value > 0.5:
		scale = Vector2(degradation_value, degradation_value)
	move_and_collide(direction * speed * delta)


func _on_timer_timeout():
	queue_free()

	
func _exit_tree():
	#print("[   ] Bullet deleted")
	pass
	
