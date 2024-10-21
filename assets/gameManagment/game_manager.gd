extends Node

const MENU_STATE = 0
const PLAYING_STATE = 1
@onready var rocket_manager: Node2D = $RocketManager

@onready var master_spawner: Node2D = $master_spawner
@onready var ui_manager: CanvasLayer = $UIManager
@onready var shop_ui: CanvasLayer = ui_manager.shop_ui
@onready var progress: CanvasLayer = $Progress
@onready var start_button:Button = ui_manager.start_button

@onready var qte: Node2D = $QTE

var qte_playing = false
var is_start_pressed: bool = false

signal update_scrap

var steve_state = MENU_STATE

var max_prog
var start_prog

func _init():
	pass
	
func _ready():
	start_prog = $start.position.y
	max_prog = ($start.position.y - $end.position.y)
	start_button.pressed.connect(start_pressed)
	rocket_manager.visible = false
	SceneManager.upgrade_connect()
	
func _process(delta):
	var curr_prog = -(master_spawner.global_position.y - start_prog)
	curr_prog = (curr_prog / max_prog) * 100
	progress.texture_progress_bar.value = curr_prog
	print("prog: " + str(curr_prog))
	print("value: " + str(progress.texture_progress_bar.value))
	
	if (master_spawner.global_position.y < -13600 && !qte_playing):
		qte_playing = true
		qte.start_anim()
		rocket_manager.in_qte()
		
	if is_start_pressed and steve_state == MENU_STATE:
		is_start_pressed = false
		rocket_manager.start()
		steve_state = PLAYING_STATE
		rocket_manager.visible = true
		progress.visible = true
		master_spawner.start_spawner()
		
	
func steve_died():
	if (steve_state == PLAYING_STATE):
		steve_state = MENU_STATE
		ui_manager.start_canvas_layer.visible = true
		progress.visible = false
	
		rocket_manager.visible = false
		master_spawner.reset_spawner()
		shop_ui.update()
		update_scrap.emit()
	
	
func start_pressed() -> void:
	is_start_pressed = true

	
	
	
