extends Node

@export var shakeFade : float = 5.0

var shake_strength : float = 0
var camera : Camera2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_tree().get_first_node_in_group("camera")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
		camera.offset = randomOffset()

func apply_shake(strength):
	shake_strength = strength

func randomOffset():
	return Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))
