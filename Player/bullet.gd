extends CharacterBody2D

@export var speed : float = 300.0
@export var lifetime : float = 1.0
@export var damage_amount : float = 7.0

@export var degradation_value : float = 1


func _ready():
	#print("[   ] Bullet created")
	$Timer.start(lifetime)
	print("[   ] Shot bullet: ", velocity)


func _physics_process(delta):
	degradation_value = $Timer.time_left / $Timer.wait_time
	if degradation_value > 0.5:
		scale = Vector2(degradation_value, degradation_value)
	move_and_collide(global_transform.basis_xform(Vector2.RIGHT) * speed * delta)


func _on_timer_timeout():
	queue_free()

	
func _exit_tree():
	#print("[   ] Bullet deleted")
	pass
	
func _on_hitbox_area_entered(area):
	var body = area.get_parent()
	print("[   ] Hit registered, health: ", body.health)
	if body.is_in_group("destroyable"):
		body.dmg_event(self.global_position, damage_amount)
		queue_free()
