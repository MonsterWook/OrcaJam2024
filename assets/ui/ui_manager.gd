extends CanvasLayer
@onready var start_canvas_layer: CanvasLayer = $CanvasLayer
@onready var shop_ui: CanvasLayer = $ShopUI
"@onready var shop_button: Button = $MarginContainer/ShopButton
@onready var start_button: Button = $MarginContainer2/StartButton
@onready var back_button: Button = $ShopUI/MarginContainer4/BackButton
"
@onready var shop_ui_canvas: CanvasLayer = $"."
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(start_canvas_layer)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_start():
	start_canvas_layer.visible = false
	
func on_shop():
	shop_ui_canvas.visible = true

func on_back():
	shop_ui_canvas.visible = false
