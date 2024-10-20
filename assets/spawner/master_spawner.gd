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
<<<<<<< Updated upstream

=======
const background : Array[PackedScene] = [
	preload("res://assets/background/Background_assets/clouds.tscn"),
	preload("res://assets/background/Background_assets/star.tscn")
]
var playing_game : bool = false
var start_pos : Vector2
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
func current_altitude():
	return player.altitude
=======
func _on_spawn_timer_timeout():
	var obstacles = current_location()
	#obstacle spawner
	for i in range(randi_range(1,2)):
		var obstacle = obstacles[randi_range(0, 1)]
		if (obstacles == obstacles_surface || obstacle == obstacles_space[1]):
			spawn_obstacle(obstacle, side_spawner)
		else:
			spawn_obstacle(obstacle, general_spawner)
	#scrap spawner
	for i in range(randi_range(0, 2)):
		var scrap = obstacles[2]
		spawn_obstacle(scrap, general_spawner)
	if (obstacles == obstacles_surface):
		var obstacle = background[0]
		spawn_obstacle(obstacle, side_spawner)
	elif(obstacles_surface == obstacles_space):
		var obstacle = background[1]
		spawn_obstacle(obstacle, general_spawner)
		spawn_obstacle(obstacle, general_spawner)
		spawn_obstacle(obstacle, general_spawner)
		spawn_obstacle(obstacle, general_spawner)
		spawn_obstacle(obstacle, general_spawner)

func stop_timers():
	spawn_timer_1.stop()
	spawn_timer_2.stop()
func start_timers():
	spawn_timer_1.start()
	spawn_timer_2.start()
>>>>>>> Stashed changes
