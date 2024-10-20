extends Node

const MENU_STATE = 0
const PLAYING_STATE = 1
@onready var rocket_manager: Node2D = $RocketManager
@onready var shop_ui: CanvasLayer = $ShopUI
@onready var master_spawner: Node2D = $master_spawner

@onready var qte: Node2D = $QTE

signal update_scrap

var steve_state = MENU_STATE

func _init():
	pass
	
func _ready():
	rocket_manager.visible = false
	
func reached_moon():
	qte.start_anim()
	print("we reached the moon")
	
func _process(delta):
	
	if (master_spawner.global_position.y < -12000):
		qte.start_anim()
		
	if Input.is_action_pressed("start") and steve_state == MENU_STATE:
		rocket_manager.start()
		steve_state = PLAYING_STATE
		rocket_manager.visible = true
		shop_ui.visible = false
		master_spawner.start_spawner()
		
	
func steve_died():
	if (steve_state == PLAYING_STATE):
		steve_state = MENU_STATE
		shop_ui.visible = true
	
		rocket_manager.visible = false
		master_spawner.reset_spawner()
		shop_ui.update()
		update_scrap.emit()
	
	
	

	
	
	
