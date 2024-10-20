extends CharacterBody2D

@export var SPEED : int = 100
@export var up : float = 150
@export var damage : int = 10

var spawnedDirection : bool = false #left = false, right = true
var time : float

signal destroyed(obstacle_pos, scrap)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	movement()

func movement():
	print(time)
	if (time > 1.5):
		time = 0
		up *= -1
	if (spawnedDirection):
		#move towards the left with the tiniest bit of sin movement
		velocity = Vector2(-1 * SPEED, up)
	else:
		#move towards the right with the tiniest bit of sin movement
		velocity = Vector2(1 * SPEED, up)
	move_and_slide()

func death(killed : bool):
	if (killed):
		destroyed.emit(global_position, 2)
	#play destoyed anim maybe
	queue_free()
	
func _on_area_2d_area_entered(area : Area2D):
	if (area.is_in_group("bullet")):
		death(true)
	if (area.is_in_group("player")):
		death(false)
		area.get_parent().get_parent().take_damage(damage)
