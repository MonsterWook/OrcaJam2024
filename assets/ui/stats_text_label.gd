extends RichTextLabel
#@onready var scene_manager = get_tree().get_nodes_in_group("scene_manager")[0]
@onready var upgrade_buttons: HBoxContainer = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SceneManager.update_stats_text.connect(update_text)
	text = "%s: %s" % [upgrade_buttons.upgrade_type, upgrade_buttons.upgrade_level]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_text():
	text = "%s: %s" % [upgrade_buttons.upgrade_type, upgrade_buttons.upgrade_level]
