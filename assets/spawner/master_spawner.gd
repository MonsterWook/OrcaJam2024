extends Node2D

@export var max_surface = 5000
@export var max_stratosphere = 15000
@export var max_space : int = 30000
@export var vertical_speed : int = -100

@onready var general_spawner = $general_spawner
@onready var side_spawner = $side_spawner
@onready var spawn_timer_1: Timer = $spawn_timer1
@onready var spawn_timer_2: Timer = $spawn_timer2
@onready var background_spawner: Timer = $background_spawner

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
const background : Array[PackedScene] = [
	preload("res://assets/background/Background_assets/clouds.tscn"),
	preload("res://assets/background/Background_assets/star.tscn")
]

var playing_game : bool = false
var start_pos : Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	start_pos = global_position
	reset_spawner()

func _process(delta: float) -> void:
	if(playing_game):
		position.y += vertical_speed*delta

func reset_spawner():
	stop_timers()
	playing_game = false
	global_position = start_pos

func start_spawner():
	start_timers()
	playing_game = true

func spawn_obstacle(obstacle : PackedScene, spawner : Node2D):
	spawner.spawn(obstacle)

func current_location():
	var altitude = global_position.y
	if (altitude > max_surface):
		return obstacles_surface
	elif (altitude > max_stratosphere):
		return obstacles_stratosphere
	else:
		return obstacles_space

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

func background_spawn_timeout():
	var obstacles = current_location()
	if (obstacles == obstacles_surface || obstacles == obstacles_stratosphere):
		var obstacle = background[0]
		spawn_obstacle(obstacle, side_spawner)
	elif(obstacles == obstacles_space):
		var obstacle = background[1]
		spawn_obstacle(obstacle, general_spawner)
		spawn_obstacle(obstacle, general_spawner)
		spawn_obstacle(obstacle, general_spawner)
		spawn_obstacle(obstacle, general_spawner)
		spawn_obstacle(obstacle, general_spawner)

func stop_timers():
	spawn_timer_1.stop()
	spawn_timer_2.stop()
	background_spawner.stop()
func start_timers():
	spawn_timer_1.start()
	spawn_timer_2.start()
	background_spawner.start()
