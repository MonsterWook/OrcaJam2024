extends HBoxContainer
@onready var buttons: Array = get_children()
@onready var apply_button: Button = $"../ApplyButton"

signal apply_upgrades(level)
var upgrade_level: int = 0
var new_upgrade_level: int = 0
var temp_scrap: int = 200



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_button.pressed.connect(on_upgrade_applied)
	for i in range(len(buttons)):
		buttons[i].on_upgrade_pressed.connect(on_button_toggle)
	update_pruchasable_upgrades()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _enter_tree() -> void:
	pass

func update_pruchasable_upgrades() -> void:
	for button in buttons:
		print(button.cost)
		if button.cost > temp_scrap:
			button.disabled = true

func on_button_toggle(button_index: int):
	print("signal")
	if buttons[button_index].button_pressed == true:
		for i in range(button_index):
			buttons[i].button_pressed = false
			
	for i in range(button_index):
		buttons[i].button_pressed = true
	for i in range(button_index+1, len(buttons)):
		if(buttons[i].button_pressed):
			buttons[i].button_pressed = false

func on_upgrade_applied():
	for i in range(len(buttons)):
		if buttons[i].button_pressed == true:
			buttons[i].disabled = true
		if i > 0 and buttons[i].button_pressed == false:
			upgrade_level = i
	
	update_pruchasable_upgrades()
	apply_upgrades.emit(upgrade_level)
