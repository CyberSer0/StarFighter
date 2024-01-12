@tool
extends StaticBody2D

@export_category("Max Values")
@export var max_rotation_speed : float = 1.0
@export var max_drop_amount : int = 3

@export_category("Properties")
@export var current_rotation_speed : float = 0.0
@export_enum("red", "blue", "green") var variant : int : 
	set(value): 
		set_variant(value) 
		variant = value
	get: return variant

@export_category("Nodes")
@export var destruction_particles : GPUParticles2D
		
@onready var rng = RandomNumberGenerator.new()

@onready var collectable = preload("res://Collectables/CollectableMaterial.tscn")

func _ready():
	current_rotation_speed = rng.randf_range(-max_rotation_speed, max_rotation_speed) 


func _process(delta):
	$Sprite2D.rotate(current_rotation_speed * delta)


func set_variant(value):
	match value:
		0: modulate = Color.RED
		1: modulate = Color.BLUE
		2: modulate = Color.GREEN
		_: modulate = Color.WHITE


func _on_hit_box_body_entered(body):
	print("[   ] Projectile hit")
	destruction_particles.reparent(GLOBALS.GAMESCENE)
	destruction_particles.process_material.direction = Vector3(global_position.direction_to(body.global_position).x, global_position.direction_to(body.global_position).y, 0).normalized()
	destruction_particles.modulate = modulate
	destruction_particles.emitting = true
	body.queue_free()
	queue_free()
	generate_drops()
	

func generate_drops():
	var drop_amt = rng.randi_range(1, max_drop_amount)
	for i in range(0, drop_amt):
		var drop = collectable.instantiate()
		drop.global_position = global_position + Vector2(rng.randf_range(0, $Sprite2D.get_rect().size.x), rng.randf_range(0, $Sprite2D.get_rect().size.y))
		drop.rotation = randi_range(0, 360)
		drop.variant = variant
		GLOBALS.GAMESCENE.call_deferred("add_child", drop)
