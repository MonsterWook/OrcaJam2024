extends Node

var fuel_max: int
var fuel: int = fuel_max
var scrap: int = 2500
var temp_scrap: int = scrap

var fuel_lvl: int = 0
var tilt_lvl: int = 0
var shotgun_lvl: int = 0
var toughness_lvl: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_scrap() -> int:
	return scrap
