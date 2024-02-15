extends Node3D


func _enter_tree():
	GLOBALS.GAMESCENE = self

func _exit_tree():
	GLOBALS.GAMESCENE = null
