extends Node2D

var direction_vec: Vector2 = Vector2(0, -10)
var bullet_speed = 600

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _init():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += delta*bullet_speed*direction_vec
