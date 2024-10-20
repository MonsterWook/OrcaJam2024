extends CheckButton

@export var index: int
@export var cost: int
var cost_text: String
signal on_upgrade_pressed(button_index)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "%6s" % ""
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _pressed() -> void:
	on_upgrade_pressed.emit(index)	
