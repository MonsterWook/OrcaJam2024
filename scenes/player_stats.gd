extends Node

@onready var stats_text_label: RichTextLabel = $StatsTextLabel

var fuel_max: int
var fuel: int = fuel_max
var scrap: int = 2500
var temp_scrap: int = scrap

var fuel_lvl: int = 0
var tilt_lvl: int = 0
var shotgun_lvl: int = 0
var toughness_lvl: int = 0

@onready var upgrades = get_tree().get_nodes_in_group("upgrades")

signal update_stats_text()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for upgrade in upgrades:
		upgrade.apply_upgrades.connect(apply_upgrade)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_scrap() -> int:
	return scrap

func apply_upgrade(upgrade_type: String, upgrade_level: int) -> void:

	match upgrade_type:
		"Fuel":
			fuel_lvl = upgrade_level
		"Shotgun":
			shotgun_lvl = upgrade_level
		"Tilt":
			tilt_lvl = upgrade_level
		"Toughness":
			toughness_lvl = upgrade_level
	update_stats_text.emit()
