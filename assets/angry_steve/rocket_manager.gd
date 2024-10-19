extends Node2D

const BULLET = preload("res://assets/angry_steve/bullet.tscn")
@onready var rocket_movement: Node2D = $RocketMovement

func _init():
	print("succesfully started")


func _process(delta: float) -> void:
	# if the shoot butten is pressed spawn bullet at the gun spawn point with the
	# movement direction of the rotation of the rocket
	if Input.is_action_pressed("boost"):
		pass
		rocket_movement.get_bullet_stats()	
