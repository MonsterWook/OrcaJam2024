extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("cutscene")
	animated_sprite_2d.play("one")

func transition_to_game():
	get_tree().change_scene_to_file("res://assets/gameManagment/game_manager.tscn")
