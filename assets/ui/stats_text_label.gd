extends RichTextLabel
@onready var scene_manager = get_tree().get_nodes_in_group("scene_manager")[0]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text ="Fuel: {scene_manager.fuel_lvl}
Tilt Speed: {scene_manager.tilt_lvl}
Shotgun Ammo: {scene_manager.shotgun_lvl}
Thoughness: {scene_manager.toughness_lvl}"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
