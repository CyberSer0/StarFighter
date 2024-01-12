extends Node2D

@export var main_game_scene : PackedScene

func _ready():
	#await get_tree().create_timer(3).timeout
	get_tree().call_deferred("change_scene_to_packed", main_game_scene)
