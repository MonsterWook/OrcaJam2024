extends HBoxContainer
@onready var buttons: Array = get_children()
@onready var apply_button: Button = $"../ApplyButton"
@onready var scene_manager = get_tree().get_nodes_in_group("scene_manager")[0]
@onready var temp_scrap: int = scene_manager.temp_scrap

signal apply_upgrades(level)

var upgrade_level: int = 0
var new_upgrade_level: int = 0
var total_cost: int = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	temp_scrap=scene_manager.scrap
	apply_button.pressed.connect(on_upgrade_applied)
	for i in range(len(buttons)):
		buttons[i].on_upgrade_pressed.connect(on_button_toggle)
		total_cost+=buttons[i].cost
	update_purchasable_upgrades()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _enter_tree() -> void:
	pass


func update_purchasable_upgrades() -> void:
	total_cost = 0
	temp_scrap = scene_manager.temp_scrap
	for i in range(len(buttons)):
		if(not buttons[i].disabled or not buttons[i].button_pressed):
			total_cost+=buttons[i].cost
			buttons[i].text = "%6s" % total_cost
			if total_cost > temp_scrap and not buttons[i].button_pressed:
				buttons[i].disabled = true
			else:
				buttons[i].disabled = false

func on_button_toggle(button_index: int):
	if buttons[button_index].button_pressed:
		temp_scrap -= buttons[button_index].cost	
	else:
		temp_scrap += buttons[button_index].cost	
		
	for i in range(button_index):
		if(not buttons[i].button_pressed):
			temp_scrap -= buttons[i].cost
			buttons[i].button_pressed = true
		
	for i in range(button_index+1, len(buttons)):
		if(buttons[i].button_pressed):
			temp_scrap += buttons[i].cost
			buttons[i].button_pressed = false
	scene_manager.temp_scrap = temp_scrap
	print(temp_scrap)
	#update_purchasable_upgrades()
	get_tree().call_group("upgrades","update_purchasable_upgrades")

func on_upgrade_applied():
	total_cost = 0
	
	for i in range(len(buttons)):
		if buttons[i].button_pressed == true:
			buttons[i].disabled = true
		if buttons[i].button_pressed == false:
			upgrade_level = i
	
	update_purchasable_upgrades()
	apply_upgrades.emit(upgrade_level)
