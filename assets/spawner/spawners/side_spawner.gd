extends Node2D

@onready var left = $side_spawn_left/left
@onready var right = $side_spawn_right/right

var spawn_collision : CollisionShape2D

func spawn(obstacle : PackedScene):
	var spawnDirection = (1 == randi_range(0,1))
	
	if (spawnDirection):
		spawn_collision = right
	else:
		spawn_collision = left
	var rect : Rect2 = spawn_collision.shape.get_rect()
	var x = randi_range(rect.position.x, rect.position.x+rect.size.x)
	var y = randi_range(rect.position.y, rect.position.y+rect.size.y)
	var rand_point = spawn_collision.global_position + Vector2(x,y)
	
	var instance = obstacle.instantiate()
	
	instance.global_position = rand_point
	instance.spawnedDirection = spawnDirection
	
	get_tree().root.add_child(instance)
