extends RichTextLabel
var scrap_amount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scrap_amount = 0
	text = str(scrap_amount)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func increase_scrap_amount(scrap_increment: int) -> void:
	scrap_amount += scrap_increment
	text = str(scrap_amount)
