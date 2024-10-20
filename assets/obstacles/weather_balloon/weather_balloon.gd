extends CharacterBody2D

@export var SPEED : int = 25
@export var damage : int = 10

var spawnedDirection : bool = false #left = false, right = true
var rot : float = 0
var cam_shake

signal destroyed(obstacle_pos, scrap)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (spawnedDirection):
		rot = randf_range(4* PI/3, 3 * PI/2)
	else:
		rot = randf_range(3 * PI/2, 5 * PI/3)
	cam_shake = get_tree().get_first_node_in_group("camera_shake")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement()

func movement():
	#very small movement upwards
	velocity = Vector2(SPEED, 0).rotated(rot)
	move_and_slide()

func death(killed : bool):
	if (killed):
		destroyed.emit(global_position, 1)
	cam_shake.apply_shake(20)
	queue_free()

func _on_area_2d_area_entered(area : Area2D):
	if (area.is_in_group("bullet")):
		death(true)
		area.get_parent().queue_free()
	if (area.is_in_group("player")):
		death(false)
		area.get_parent().get_parent().take_damage(damage)
