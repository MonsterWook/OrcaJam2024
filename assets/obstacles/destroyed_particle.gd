extends Node2D

var particle : PackedScene = preload("res://assets/obstacles/destroyed_particle.tscn")
func _on_destroyed(obstacle_pos, scrap):
	var instance = particle.instantiate()
	
	instance.emitting = true
	instance.global_position = obstacle_pos
	get_tree().root.add_child(instance)
