extends CharacterBody2D

@export var SPEED : int = 25
var spawnedDirection : bool = false #left = false, right = true
var rot : float = 0
signal destroyed(obstacle_pos, scrap)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (spawnedDirection):
		rot = randf_range(4* PI/3, 3 * PI/2)
	else:
		rot = randf_range(3 * PI/2, 5 * PI/3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_key_pressed(KEY_SPACE)):
		death(true)
	movement()

func movement():
	#very small movement upwards
	velocity = Vector2(SPEED, 0).rotated(rot)
	move_and_slide()

func death(killed : bool):
	if (killed):
		destroyed.emit(global_position, 1)
	#play destoyed anim maybe
	queue_free()

func _on_area_2d_area_entered(area : Area2D):
	if (area.is_in_group("bullet")):
		death(true)
	if (area.is_in_group("player")):
		death(false)
