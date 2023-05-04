extends StaticBody2D

@export var rotation_speed : float = 1.0


func _process(delta):
	rotate(rotation_speed * delta)
