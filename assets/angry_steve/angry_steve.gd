extends Node2D

var direction = Vector2(0, 0)
const bullet = preload("res://assets/angry_steve/bullet.tscn")
@onready var bullet_spawn: Node2D = $AnimatedSprite2D/gun/BulletSpawn
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.
	

func get_gun_spawn():
	#return bullet_spawn.global_position
	return bullet_spawn.position
