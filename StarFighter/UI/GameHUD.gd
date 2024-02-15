extends Control

@export var red_amount : int :
	set(amount):
		$HBoxContainer/Amounts/RedAmount.text = amount
		red_amount = amount
		
@export var green_amount : int :
	set(amount):
		$HBoxContainer/Amounts/GreenAmount.text = amount
		green_amount = amount
		
@export var blue_amount : int :
	set(amount):
		$HBoxContainer/Amounts/BlueAmount.text = amount
		blue_amount = amount

func _enter_tree():
	GLOBALS.CURRENT_HUD = self


