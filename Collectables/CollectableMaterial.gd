extends Node2D


@export_enum("red", "blue", "green") var variant : int : 
	set(value): 
		set_variant(value) 
		variant = value
	get: return variant

@export_category("Pop values")
@export var pop_target : Vector2
@export var pop_time : float
var animtimer : Timer

func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", global_position + pop_target, pop_time).set_ease(Tween.EASE_IN_OUT)


func set_variant(value):
	match value:
		0: modulate = Color.RED
		1: modulate = Color.GREEN
		2: modulate = Color.BLUE
		_: modulate = Color.WHITE
