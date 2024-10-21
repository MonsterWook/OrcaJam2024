extends CanvasLayer
@onready var shop_ui: CanvasLayer = $ShopUI
@onready var start_canvas_layer: CanvasLayer = $StartCanvasLayer

@onready var shop_button: Button = start_canvas_layer.shop_button
@onready var start_button: Button = start_canvas_layer.start_button
@onready var back_button: Button = shop_ui.back_button
@onready var apply_button: Button = shop_ui.apply_button
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shop_button.shop_button_pressed.connect(on_shop)
	start_button.start_button_pressed.connect(on_start)
	apply_button.pressed.connect(on_back)
	print(shop_button)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_start():
	start_canvas_layer.visible = false
	
func on_shop():
	shop_ui.visible = true
	start_canvas_layer.visible = false

func on_back():
	shop_ui.visible = false
	start_canvas_layer.visible = true
