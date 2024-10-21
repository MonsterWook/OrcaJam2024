extends Button
@onready var menu_click: AudioStreamPlayer = $MenuClick

signal shop_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _pressed() -> void:
	menu_click.play()
	shop_button_pressed.emit()
