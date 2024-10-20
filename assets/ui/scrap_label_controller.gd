extends RichTextLabel

@onready var upgrades = get_tree().get_nodes_in_group("upgrades")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for upgrade in upgrades:
		upgrade.update_scrap.connect(update_scrap_amount)
	update_scrap_amount()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func increase_scrap_amount(scrap_increment: int) -> void:
	SceneManager.scrap+= scrap_increment
	update_scrap_amount()

func update_scrap_amount():
	text = str(SceneManager.scrap)
