extends Node2D

const scrap : PackedScene = preload("res://assets/obstacles/scrap/scrap.tscn")

func spawn():
	var instance = scrap.instantiate()
	
	#spawn it from destroyed obstacles
	get_tree().current_scene.add_child(instance)

func _on_destroyed():
	spawn()
