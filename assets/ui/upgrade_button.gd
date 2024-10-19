extends CheckButton
@export var index: int
@export var cost: int
signal on_upgrade_pressed(button_index)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(cost)
	pressed.connect(upgrade_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func upgrade_pressed():
	on_upgrade_pressed.emit(index)
