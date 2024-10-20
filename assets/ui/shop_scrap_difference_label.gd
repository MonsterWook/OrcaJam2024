extends RichTextLabel

@onready var upgrades = get_tree().get_nodes_in_group("upgrades")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#SceneManager.update_scrap_difference.connect(update_text)
	for upgrade in upgrades:
		upgrade.update_scrap_difference.connect(update_text)
	update_text()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_text() -> void:
	text = str(-(SceneManager.scrap - SceneManager.temp_scrap))
