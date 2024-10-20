extends Node2D

@export var max_surface = 5000
@export var max_stratosphere = 15000
@export var max_space : int = 30000
@export var vertical_speed : int = -100

@onready var general_spawner = $general_spawner
@onready var side_spawner = $side_spawner

const obstacles_surface : Array[PackedScene] = [
	preload("res://assets/obstacles/bird/bird.tscn"),
	preload("res://assets/obstacles/plane/plane.tscn"),
	
	preload("res://assets/obstacles/scrap/scrap.tscn"),
]
const obstacles_stratosphere : Array[PackedScene] = [
	preload("res://assets/obstacles/satellite/satellite.tscn"),
	preload("res://assets/obstacles/weather_balloon/weather_balloon.tscn"),

	preload("res://assets/obstacles/scrap/scrap_silver.tscn")
]
const obstacles_space : Array[PackedScene] = [
	preload("res://assets/obstacles/asteroids/asteroid.tscn"),
	preload("res://assets/obstacles/aliens/aliens.tscn"),
	
	preload("res://assets/obstacles/scrap/scrap_gold.tscn")
]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += vertical_speed*delta

func spawn_obstacle(obstacle : PackedScene, spawner : Node2D):
	print(global_position.y)
	spawner.spawn(obstacle)

func current_location():
	var altitude = global_position.y
	if (altitude > max_surface):
		return obstacles_surface
	elif (altitude > max_stratosphere):
		return obstacles_stratosphere
	elif ( altitude > max_space):
		return obstacles_space

func _on_spawn_timer_timeout():
	var obstacles = current_location()
	#obstacle spawner
	for i in range(randi_range(1,2)):
		var obstacle = obstacles[randi_range(0, 1)]
		if (obstacles == obstacles_surface):
			spawn_obstacle(obstacle, side_spawner)
		else:
			spawn_obstacle(obstacle, general_spawner)
	#scrap spawner
	for i in range(randi_range(0, 2)):
		var scrap = obstacles[2]
		spawn_obstacle(scrap, general_spawner)
