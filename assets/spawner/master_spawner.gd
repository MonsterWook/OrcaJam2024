extends Node2D

@export var player : CharacterBody2D
@export var max_surface = 5000
@export var max_stratosphere = 15000
@export var max_space : int = 30000

@onready var s_bird : Node2D = self.get_node("spawn_bird")
@onready var s_plane : Node2D = self.get_node("spawn_plane")
@onready var s_satellite : Node2D = self.get_node("spawn_satellite")
@onready var s_weather_balloon : Node2D = self.get_node("spawn_weather_balloon")
@onready var s_asteroid : Node2D = self.get_node("spawn_asteroid")
@onready var s_alien : Node2D = self.get_node("spawn_alien")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_obstacle(obstacle : Node2D):
	obstacle.spawn()

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
