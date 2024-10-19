extends CharacterBody2D

@export var SPEED : int = 100
@export var sin_wave_intensity : int = 25
@export var sin_wave_speed : float = 2

var spawnedDirection : bool = false #left = false, right = true
var time : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	movement()

func movement():
	#easy movement just go from the left of the screen to the right or vice versa
	if (spawnedDirection):
		#move towards the left with the tiniest bit of sin movement
		velocity = Vector2(-1 * SPEED, get_sine())
	else:
		#move towards the right with the tiniest bit of sin movement
		velocity = Vector2(1 * SPEED, get_sine())
	move_and_slide()
	
func get_sine():
	return sin(time * sin_wave_speed) * sin_wave_intensity
