extends Node


func spawn(obstacle : PackedScene):
	var spawnDirection = (1 == randi_range(0,1))
	var instance = obstacle.instantiate()
	
	instance.spawnedDirectrion = spawnDirection
	get_tree().current_scene.add_child(instance)
