extends Node2D

enum {NORMAL, SILVER, GOLD}
const scraps : Array[PackedScene] = [
	preload("res://assets/obstacles/scrap/scrap.tscn"),
	preload("res://assets/obstacles/scrap/scrap_silver.tscn"),
	preload("res://assets/obstacles/scrap/scrap_gold.tscn")
	]

func spawn(obstacle_pos : Vector2, scrap : int):
	var instance = scraps[scrap].instantiate()
	var rand_pos = Vector2(obstacle_pos.x + randi_range(-50, 50), obstacle_pos.y + randi_range(-25, 25))
	#add a tween to go to pos
	instance.global_position = rand_pos
	get_tree().current_scene.add_child(instance)

func _on_destroyed(obstacle_pos : Vector2, scrap : int):
	for x in range(randi_range(1, 4)):
		spawn(obstacle_pos, scrap)
