extends Node

const MENU_STATE = 0
const PLAYING_STATE = 1
@onready var rocket_manager: Node2D = $RocketManager

var steve_state = MENU_STATE

func _init():
	pass
	
func _process(delta):
	if Input.is_action_pressed("boost") and steve_state == MENU_STATE:
		rocket_manager.start()
		steve_state = PLAYING_STATE
	
func steve_died():
	steve_state = MENU_STATE
	
	
	
