extends CharacterBody2D

@export var SPEED : int = 25
@export var ROT_SPEED : float = 50
@export var damage : int = 10

@onready var sprite = $Sprite2D
@onready var explode = $sfx/explode
@onready var death_sfx = $sfx/death
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var area_2d = $Area2D

var spawnedDirection : bool = false #left = false, right = true
var rot : float = 0
var cam_shake
var sfx

signal destroyed(obstalce_pos, scrap)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (spawnedDirection):
		rot = randf_range(4 * PI/3, 2 * PI)
	else:
		rot = randf_range(PI,5 * PI/3)
	cam_shake = get_tree().get_first_node_in_group("camera_shake")
	sfx = get_tree().get_first_node_in_group("sfx")

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
		sfx.play_sound(explode)
		destroyed.emit(global_position, 2)
	cam_shake.apply_shake(20)
	sfx.play_sound(death_sfx)
	area_2d.set_deferred("process_mode", PROCESS_MODE_DISABLED)
	collision_shape_2d.set_disabled(true)
	visible = false

func _on_area_2d_area_entered(area : Area2D):
	if (area.is_in_group("bullet")):
		death(true)
		area.get_parent().queue_free()
	if (area.is_in_group("player")):
		death(false)
		area.get_parent().get_parent().take_damage(damage)
