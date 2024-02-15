extends CharacterBody2D

const SPEED : float = 100.0
const MAX_VELOCITY : float = 3.0 
const ROTATION_SPEED : float = 2.0

@export_group("Visual Effects")
@export var engine_particles_container : Node2D
@export var strafing_engine_particles : Node2D

@export_group("Shooting")
@export var aiming_point : Node2D
@export var turret_container : Node2D
@export var is_shooting : bool = false
@onready var cd_timer : Timer = Timer.new()

@export_subgroup("Movement")
@export var steering_vertical : float
@export var steering_horizontal : float
@export var strafing_horizontal : float
@export var strafe : int = 0 

@export_group("Inventory")
@export var inventory_red : int = 0 :
	set(amount):
		GLOBALS.CURRENT_HUD.get_node("InvContainer/Amounts/RedAmount").text = str(amount)
		inventory_red = amount
@export var inventory_green : int = 0 :
	set(amount):
		GLOBALS.CURRENT_HUD.get_node("InvContainer/Amounts/GreenAmount").text = str(amount)
		inventory_green = amount
@export var inventory_blue : int = 0 :
	set(amount):
		GLOBALS.CURRENT_HUD.get_node("InvContainer/Amounts/BlueAmount").text = str(amount)
		inventory_blue = amount



func _ready():
	cd_timer.wait_time = turret_container.shooting_cooldown
	cd_timer.connect("timeout", cd_timer_timeout)
	add_child(cd_timer)
	
	GLOBALS.PLAYER = self


func _process(delta):
	steering_vertical = Input.get_axis("throttle_down", "throttle_up")
	steering_horizontal = Input.get_axis("steer_left", "steer_right")
	strafing_horizontal = Input.get_axis("strafe_right", "strafe_left")
	
	engine_particles_container.player_direction = steering_vertical
	strafing_engine_particles.strafing_direction = strafing_horizontal
	
	rotation += deg_to_rad(steering_horizontal * ROTATION_SPEED)
	velocity = global_transform.basis_xform((Vector2.RIGHT * steering_vertical + Vector2.UP * strafing_horizontal) * SPEED)
	
	aiming_point.global_position = get_global_mouse_position()
	turret_container.look_at(aiming_point.global_position)
	
	move_and_slide()


func _physics_process(delta):
	if turret_container.can_shoot and is_shooting:
		turret_container.shoot()
		
		cd_timer.start()
	
	
	
func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		is_shooting = true
	
	if event.is_action_released("shoot"):
		is_shooting = false
			

func _exit_tree():
	GLOBALS.PLAYER = null


func _on_collector_area_area_entered(area : Area2D):
	if area.is_in_group("material"):
		var collectable = area.get_parent()
		match collectable.variant:
			0: inventory_red += 1
			1: inventory_green += 1
			2: inventory_blue += 1
			_: print("[ X ] Failed to get collectable variant")
		collectable.queue_free()
		print(get_inventory())


func cd_timer_timeout():
	#print("[   ] CD Timeout")
	turret_container.can_shoot = true


func get_inventory():
	return {"red" : inventory_red, 
			"green" : inventory_green, 
			"blue" : inventory_blue}
