
extends Node

#@onready var stats_text_label: RichTextLabel = $MarginContainer/StatsTextLabel

var fuel_max: int
var fuel: int = fuel_max
var scrap: int = 0
var temp_scrap: int = scrap

var fuel_lvl: int = 0
var tilt_lvl: int = 0
var shotgun_lvl: int = 0
var toughness_lvl: int = 0

@onready var upgrades : Array

signal update_stats_text

func upgrade_connect():
	upgrades = get_tree().get_nodes_in_group("upgrades")
	for upgrade in upgrades:
		upgrade.apply_upgrades.connect(apply_upgrade)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_scrap() -> int:
	return scrap
	
func set_scrap(new_scrap_amount: int) -> void:
	scrap = new_scrap_amount

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
