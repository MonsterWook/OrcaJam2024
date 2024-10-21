extends Node2D

@export var gm : Node

@onready var layer_1 : AudioStreamPlayer = $Layer1
@onready var menu_music : AudioStreamPlayer = $MenuMusic

func _process(delta):
	if(gm.qte_playing):
		menu_music.stop()
		layer_1.stop()
	elif(gm.steve_state == gm.PLAYING_STATE):
		if(!layer_1.playing):
			layer_1.play()
			menu_music.stop()
	elif(gm.steve_state == gm.MENU_STATE):
		if(!menu_music.playing):
			menu_music.play()
			layer_1.stop()
	
