extends Node

const MENU_STATE = 0
const PLAYING_STATE = 1
@onready var rocket_manager: Node2D = $RocketManager

@onready var master_spawner: Node2D = $master_spawner
@onready var ui_manager: CanvasLayer = $UIManager
@onready var shop_ui: CanvasLayer = ui_manager.shop_ui
@onready var start_button:Button = ui_manager.start_button

@onready var qte: Node2D = $QTE
var qte_playing = false

var is_start_pressed: bool = false

signal update_scrap

var steve_state = MENU_STATE

func _init():
	pass
	
func _ready():
	start_button.pressed.connect(start_pressed)
	rocket_manager.visible = false
	
func _process(delta):
	print("PLEASE2" + str(master_spawner.global_position.y))
	if (master_spawner.global_position.y < -13200):
		#qte_playing = true
		#qte.start_anim()
		get_tree().quit()
		
	if is_start_pressed and steve_state == MENU_STATE:
		is_start_pressed = false
		rocket_manager.start()
		steve_state = PLAYING_STATE
		rocket_manager.visible = true
		master_spawner.start_spawner()
		
	
func steve_died():
	if (steve_state == PLAYING_STATE):
		steve_state = MENU_STATE
		ui_manager.start_canvas_layer.visible = true
	
		rocket_manager.visible = false
		master_spawner.reset_spawner()
		shop_ui.update()
		update_scrap.emit()
	
	
func start_pressed() -> void:
	is_start_pressed = true

	
	
	
