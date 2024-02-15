extends Node2D


@export var shooting_cooldown : float = 0.01
@export var can_shoot : bool = true

@onready var preloadedBullet = preload("res://Player/bullet.tscn")


func shoot():
	if can_shoot:
		can_shoot = false
		for each in get_child(0).get_children():
			var bullet = preloadedBullet.instantiate()
			bullet.global_position = each.global_position
			bullet.rotation = global_transform.basis_xform(Vector2.RIGHT).angle()
			bullet.velocity += get_parent().velocity
			GLOBALS.GAMESCENE.add_child(bullet)
