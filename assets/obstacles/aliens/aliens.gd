extends CharacterBody2D

@export var SPEED : int = 100
@export var up : float = 150
@export var damage : int = 10

@onready var sprite : AnimatedSprite2D = $Sprite2D
@onready var explode = $sfx/explode
@onready var death_sfx = $sfx/death
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var area_2d = $Area2D

var spawnedDirection : bool = false #left = false, right = true
var time : float
var cam_shake
var sfx

signal destroyed(obstacle_pos, scrap)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play()
	cam_shake = get_tree().get_first_node_in_group("camera_shake")
	sfx = get_tree().get_first_node_in_group("sfx")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	movement()

func movement():
	if (time > 1.5):
		time = 0
		up *= -1
	if (spawnedDirection):
		#move towards the left with the tiniest bit of sin movement
		velocity = Vector2(-1 * SPEED, up)
		sprite.flip_h = false
	else:
		#move towards the right with the tiniest bit of sin movement
		velocity = Vector2(1 * SPEED, up)
		sprite.flip_h = true
	move_and_slide()

func death(killed : bool):
	if (killed):
		sfx.play_sound(explode)
		destroyed.emit(global_position, 2)
	cam_shake.apply_shake(35)
	sfx.play_sound(death_sfx)
	area_2d.set_deferred("process_mode", PROCESS_MODE_DISABLED)
	collision_shape_2d.set_deferred("disabled", true)
	visible = false
	
func _on_area_2d_area_entered(area : Area2D):
	if (area.is_in_group("bullet")):
		death(true)
		area.get_parent().queue_free()
	if (area.is_in_group("player")):
		death(false)
		area.get_parent().get_parent().take_damage(damage)
