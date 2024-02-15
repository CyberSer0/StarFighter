extends Node3D

@export_category("Movement variables")
@export var camera_max_speed : float = 15.0

@export var steering_horizontal : float 
@export var steering_vertical : float

@export var steering_intent : Vector3

@export var is_following_player : bool = false


func _physics_process(delta):
	steering_horizontal = Input.get_axis("steer_left", "steer_right")
	steering_vertical = Input.get_axis("throttle_down", "throttle_up")
	rotate(Vector3.UP, -Input.get_axis("strafe_left", "strafe_right") * 2.5 * delta)
	global_position += Vector3(steering_vertical * 2, 0, steering_horizontal).rotated(Vector3.UP, PI / 4 + rotation.y) * camera_max_speed * delta


func _input(event):
	if (event.is_action("zoom_in") or event.is_action("zoom_out")) and $Camera3D.size + Input.get_axis("zoom_in", "zoom_out") >= 0.5 and $Camera3D.size + Input.get_axis("zoom_in", "zoom_out") <= 22.5:
		$Camera3D.size += Input.get_axis("zoom_in", "zoom_out")
		print($Camera3D.size)
