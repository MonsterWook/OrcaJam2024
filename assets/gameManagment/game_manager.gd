extends Node

const MENU_STATE = 0
const PLAYING_STATE = 1
@onready var rocket_manager: Node2D = $RocketManager
@onready var shop_ui: CanvasLayer = $ShopUI
@onready var master_spawner: Node2D = $master_spawner

var steve_state = MENU_STATE

func _init():
	pass
	
func _ready():
	rocket_manager.visible = false
	
func _process(delta):
	if Input.is_action_pressed("boost") and steve_state == MENU_STATE:
		rocket_manager.start()
		steve_state = PLAYING_STATE
		rocket_manager.visible = true
		shop_ui.visible = false
		master_spawner.start_spawner()
		
	
func steve_died():
	steve_state = MENU_STATE
	shop_ui.visible = true
	rocket_manager.visible = false
	master_spawner.reset_spawner()
	
	

	
	
	
