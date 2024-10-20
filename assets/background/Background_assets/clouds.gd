extends CharacterBody2D

@export var SPEED : int = 100

@onready var sprite = $AnimatedSprite2D

var spawnedDirection : bool = false #left = false, right = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement()

func movement():
	#easy movement just go from the left of the screen to the right or vice versa
	if (spawnedDirection):
		#move towards the left with the tiniest bit of sin movement
		velocity = Vector2(-1 * SPEED, 0)
		sprite.flip_h = false
	else:
		#move towards the right with the tiniest bit of sin movement
		velocity = Vector2(1 * SPEED, 0)
		sprite.flip_h = true
	move_and_slide()
