extends CanvasLayer

@onready var steve: Sprite2D = $TextureProgressBar/steve
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	steve.position.x = texture_progress_bar.value * (texture_progress_bar.size.x / 100)
