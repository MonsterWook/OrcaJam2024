extends CharacterBody2D

@export var SPEED : int = 25
@export var ROT_SPEED : float = 50
@export var damage : int = 10

@onready var sprite = $Sprite2D

var spawnedDirection : bool = false #left = false, right = true
var rot : float = 0
signal destroyed(obstalce_pos, scrap)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (spawnedDirection):
		rot = randf_range(4 * PI/3, 2 * PI)
	else:
		rot = randf_range(PI,5 * PI/3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement()

func movement():
	#very small movement while spinning
	velocity = Vector2(-SPEED, 0).rotated(rot)
	sprite.rotation_degrees += ROT_SPEED / 100
	move_and_slide()

func death(killed : bool):
	if (killed):
		destroyed.emit(global_position, 2)
	#play destoyed anim maybe
	queue_free()

func _on_area_2d_area_entered(area : Area2D):
	if (area.is_in_group("bullet")):
		death(true)
		area.get_parent().queue_free()
	if (area.is_in_group("player")):
		death(false)
		area.get_parent().get_parent().take_damage(damage)
