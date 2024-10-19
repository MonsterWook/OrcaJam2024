extends Node2D

const bullet = preload("res://assets/angry_steve/bullet.tscn")
@onready var rocket_movement: Node2D = $RocketMovement

func _init():
	print("succesfully started")


func _process(delta: float) -> void:
	# if the shoot butten is pressed spawn bullet at the gun spawn point with the
	# movement direction of the rotation of the rocket
	if Input.is_action_just_pressed("boost"):
		var result = rocket_movement.get_bullet_stats()	
		var instance = bullet.instantiate()
		instance.position = result[0]
		instance.direction_vec = result[1]
		add_child(instance)
		
