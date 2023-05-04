extends StaticBody2D

@export var speed : float = 200.0
@export var direction : Vector2 = Vector2.ZERO

func _ready():
	print("Bullet created")


func _process(delta):
	move_and_collide(direction * speed * delta)


func _on_timer_timeout():
	queue_free()
