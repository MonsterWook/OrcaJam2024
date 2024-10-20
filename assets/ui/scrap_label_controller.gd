extends RichTextLabel
@onready var scene_manager = get_tree().get_nodes_in_group("scene_manager")[0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_scrap_amount()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func increase_scrap_amount(scrap_increment: int) -> void:
	scene_manager.scrap+= scrap_increment
	update_scrap_amount()

func update_scrap_amount():
	text = str(scene_manager.scrap)
