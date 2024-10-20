extends CharacterBody2D

@export var SPEED : int = 100
@export var sin_wave_intensity : int = 25
@export var sin_wave_speed : float = 2
@export var damage : int = 10

@onready var sprite : AnimatedSprite2D = $Sprite2D

var spawnedDirection : bool = false #left = false, right = true
var time : float
var cam_shake

signal destroyed(obstalce_pos, scrap)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play()
	cam_shake = get_tree().get_first_node_in_group("camera_shake")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	movement()

func movement():
	#easy movement just go from the left of the screen to the right or vice versa
	if (spawnedDirection):
		#move towards the left with the tiniest bit of sin movement
		velocity = Vector2(-1 * SPEED, get_sine())
		sprite.flip_h = false
	else:
		#move towards the right with the tiniest bit of sin movement
		velocity = Vector2(1 * SPEED, get_sine())
		sprite.flip_h = true
	move_and_slide()

func death(killed : bool):
	if (killed):
		destroyed.emit(global_position, 0)
	cam_shake.apply_shake(20)
	queue_free()

func get_sine():
	return sin(time * sin_wave_speed) * sin_wave_intensity

func _on_area_2d_area_entered(area : Area2D):
	if (area.is_in_group("bullet")):
		death(true)
		area.get_parent().queue_free()
	if (area.is_in_group("player")):
		death(false)
		area.get_parent().get_parent().take_damage(damage)
