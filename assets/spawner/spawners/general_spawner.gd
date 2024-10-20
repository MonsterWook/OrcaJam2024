extends Node2D

@onready var collision_shape_2d = $general_spawn/CollisionShape2D

func spawn(obstacle : PackedScene):
	var spawnDirection = (1 == randi_range(0,1))

	var rect : Rect2 = collision_shape_2d.shape.get_rect()
	var x = randi_range(rect.position.x, rect.position.x+rect.size.x)
	var y = randi_range(rect.position.y, rect.position.y+rect.size.y)
	var rand_point = collision_shape_2d.global_position + Vector2(x,y)
	
	var instance = obstacle.instantiate()
	
	instance.global_position = rand_point
	instance.spawnedDirection = spawnDirection
	
	get_tree().root.add_child(instance)
