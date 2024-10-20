extends CanvasLayer
@onready var shop_scrap_label: RichTextLabel = $ShopUI/MarginContainer2/ScrapLabelContainer/MarginContainer/VBoxContainer/ShopScrapLabel
@onready var shop_scrap_difference_label: RichTextLabel = $ShopUI/MarginContainer2/ScrapLabelContainer/MarginContainer/VBoxContainer/ShopScrapDifferenceLabel
@onready var upgrades = get_tree().get_nodes_in_group("upgrades")
@onready var back_button: Button = $ShopUI/MarginContainer4/BackButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update() -> void:
	SceneManager.temp_scrap = SceneManager.get_scrap()
	shop_scrap_label.update_scrap_amount()
	shop_scrap_difference_label.update_text()
	for upgrade in upgrades:
		upgrade.update_purchasable_upgrades()
	
