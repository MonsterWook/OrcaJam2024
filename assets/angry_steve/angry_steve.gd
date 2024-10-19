extends Node2D

var direction = Vector2(0, 0)
const bullet = preload("res://assets/angry_steve/bullet.tscn")
@onready var bullet_spawn: Node2D = $AnimatedSprite2D/gun/BulletSpawn
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func shoot(direction: Vector2):
	var instance = bullet.instantiate()
	add_child(instance)
	
	instance.position = bullet_spawn.position
	instance.direction_vec = direction
	

func get_gun_spawn():
	return bullet_spawn.global_position
