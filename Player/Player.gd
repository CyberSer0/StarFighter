extends CharacterBody2D

const SPEED : float = 100.0
const MAX_VELOCITY : float = 2.0 
const ROTATION_SPEED : float = 5.0

@export var engine_particles : GPUParticles2D
@export var aiming_point : Node2D

@onready var preloadedBullet = preload("res://Player/bullet.tscn")

var current_throttle : float = 0.0
var throttle : float = 0.0


func _ready():
	GLOBALS.PLAYER = self


func _physics_process(delta):
	var rotation = Input.get_axis("ui_left", "ui_right")
	if rotation:
		rotate(rotation * ROTATION_SPEED * delta)
	
	velocity = global_transform.basis_xform(Vector2.UP * current_throttle * SPEED)
	
	move_and_slide()
	
	
func _unhandled_input(event):
	throttle = Input.get_axis("ui_up", "ui_down")
	if throttle:
		if current_throttle < 3.0 and throttle < 0.0:
			current_throttle -= throttle
		elif current_throttle > -2.0 and throttle > 0.0:
			current_throttle -= throttle
	engine_particles.engine_mode = int(abs(current_throttle))
	
	if event.is_action_pressed("ui_accept"):
		var bullet = preloadedBullet.instantiate()
		bullet.global_position = aiming_point.global_position
		bullet.direction = global_transform.basis_xform(Vector2.UP)
		if current_throttle > 0.0:
			bullet.speed += velocity.length()
		elif current_throttle < 0.0:
			bullet.speed -= velocity.length() / 2
		get_parent().add_child(bullet)

func _exit_tree():
	GLOBALS.PLAYER = null
