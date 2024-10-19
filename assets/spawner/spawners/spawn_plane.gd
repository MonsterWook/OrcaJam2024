extends Node2D

var plane : PackedScene = preload("res://assets/obstacles/plane/plane.tscn")

func spawn():
	var spawnDirection = (1 == randi_range(0,1))
	var spawned_plane = plane.instantiate()
	
	spawned_plane.spawnedDirectrion = spawnDirection
	
	get_tree().current_scene.add_child(spawned_plane)
