extends Node2D


@export_enum("red", "blue", "green") var variant : int : 
	set(value): 
		set_variant(value) 
		variant = value
	get: return variant


func set_variant(value):
	match value:
		0: modulate = Color.RED
		1: modulate = Color.BLUE
		2: modulate = Color.GREEN
		_: modulate = Color.WHITE
