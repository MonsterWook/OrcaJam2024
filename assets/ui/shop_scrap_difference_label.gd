extends RichTextLabel

@onready var scene_manager = get_tree().get_nodes_in_group("scene_manager")[0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_text()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_text() -> void:
	text = str(scene_manager.temp_scrap)
