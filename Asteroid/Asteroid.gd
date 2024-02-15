@tool
extends StaticBody2D

@export_category("Max Values")
@export var max_health : float = 100.0
@export var max_rotation_speed : float = 1.0
@export var max_drop_amount : int = 3

@export_category("Properties")
@export var health : float
@export var current_rotation_speed : float = 0.0
@export_enum("red", "green", "blue") var variant : int : 
	set(value): 
		set_variant(value) 
		variant = value
	get: return variant

@export_category("Nodes")
@export var destruction_particles : GPUParticles2D
		
@onready var rng = RandomNumberGenerator.new()

@onready var collectable = preload("res://Collectables/CollectableMaterial.tscn")

func _ready():
	set_variant(variant) 
	health = max_health
	current_rotation_speed = rng.randf_range(-max_rotation_speed, max_rotation_speed) 


func _process(delta):
	$Sprite2D.rotate(current_rotation_speed * delta)
	pass


func set_variant(value):
	match value:
		0: $Sprite2D.self_modulate = Color.RED
		1: $Sprite2D.self_modulate = Color.GREEN
		2: $Sprite2D.self_modulate = Color.BLUE
		_: $Sprite2D.self_modulate = Color.WHITE


func generate_drops():
	var drop_amt = rng.randi_range(1, max_drop_amount)
	for i in range(0, drop_amt):
		var drop = collectable.instantiate()
		drop.global_position = global_position
		drop.pop_target = Vector2(rng.randf_range(0, $Sprite2D.get_rect().size.x), rng.randf_range(0, $Sprite2D.get_rect().size.y))
		rng.randomize()
		drop.rotation = randi_range(0, 360)
		drop.variant = variant
		GLOBALS.GAMESCENE.call_deferred("add_child", drop)


func dmg_event(hit_position : Vector2, dmg : float):
	health -= dmg
	if health <= 0.0:
		death_event(hit_position)
	
func death_event(hit_position : Vector2):
	destruction_particles.reparent(GLOBALS.GAMESCENE)
	destruction_particles.process_material.direction = -Vector3(global_position.direction_to(hit_position).x, global_position.direction_to(hit_position).y, 0).normalized()
	destruction_particles.modulate = $Sprite2D.self_modulate
	destruction_particles.emitting = true
	queue_free()
	generate_drops()
