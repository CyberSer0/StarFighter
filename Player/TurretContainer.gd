extends Node2D


@export var shooting_cooldown : float = 1.0
@export var can_shoot : bool = true

@onready var preloadedBullet = preload("res://Player/bullet.tscn")


func shoot():
	if can_shoot:
		can_shoot = false
		for each in get_child(0).get_children():
			var bullet = preloadedBullet.instantiate()
			bullet.global_position = each.global_position
			bullet.direction = global_transform.basis_xform(Vector2.RIGHT)
			if get_parent().steering_vertical > 0.0:
				bullet.speed += get_parent().velocity.length()
			elif get_parent().steering_vertical < 0.0:
				bullet.speed -= get_parent().velocity.length() / 2
			GLOBALS.GAMESCENE.add_child(bullet)
