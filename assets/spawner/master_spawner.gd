extends Node2D


@export var player : Node
@export var max_surface = 5000
@export var max_stratosphere = 15000
@export var max_space : int = 30000

@onready var general_spawner : Node2D = self.get_node("general_spawner")
@onready var side_spawner : Node2D = self.get_node("side_spawner")

enum {BIRD, PLANE, SATELLITE, WEATHER, ASTEROID, ALIENS, SCRAP, SILVER, GOLD}
const obstacles : Array[PackedScene] = [
	preload("res://assets/obstacles/bird/bird.tscn"),
	preload("res://assets/obstacles/plane/plane.tscn"),
	preload("res://assets/obstacles/satellite/satellite.tscn"),
	preload("res://assets/obstacles/weather_balloon/weather_balloon.tscn"),
	preload("res://assets/obstacles/asteroids/asteroid.tscn"),
	preload("res://assets/obstacles/aliens/aliens.tscn"),
	preload("res://assets/obstacles/scrap/scrap.tscn"),
	preload("res://assets/obstacles/scrap/scrap_silver.tscn"),
	preload("res://assets/obstacles/scrap/scrap_gold.tscn")
]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_obstacle(obstacle : PackedScene, spawner : Node2D):
	spawner.spawn(obstacle)

func current_location():
	var altitude = current_altitude()
	if (altitude < max_surface):
		return 1
	elif (altitude < max_stratosphere):
		return 2
	elif ( altitude < max_space):
		return 3

func current_altitude():
	return player.altitude
