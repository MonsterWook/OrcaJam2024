extends Node2D

const ROTATION_SPEED: float = 5
const BOOST_SPEED: float = 300
@onready var rigid_body_2d: RigidBody2D = $Rocket/RigidBody2D
@onready var angry_steve: Node2D = $Rocket/RigidBody2D/AngrySteve
@onready var rocket: Node2D = $Rocket
@onready var bullet_spawn: Node2D = $Rocket/RigidBody2D/BulletSpawn

var vertical_speed = -5
var vertical_position = 0

var max_rotation = deg_to_rad(60)
var min_rotation = deg_to_rad(-60)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("move_left") and !(rigid_body_2d.rotation < min_rotation):
		rigid_body_2d.apply_torque_impulse(-100)
		
	if Input.is_action_pressed("move_right") and !(rigid_body_2d.rotation > max_rotation):
		rigid_body_2d.apply_torque_impulse(100)
			
	if rigid_body_2d.angular_velocity < 0 and rigid_body_2d.rotation < min_rotation:
		rigid_body_2d.angular_velocity = 0
	elif rigid_body_2d.angular_velocity > 0 and rigid_body_2d.rotation > max_rotation:
		rigid_body_2d.angular_velocity = 0
	#print(rigid_body_2d.angular_velocity)
		
	var direction_vec = Vector2(sin(rigid_body_2d.rotation), -cos(rigid_body_2d.rotation))
	rigid_body_2d.apply_force(direction_vec*BOOST_SPEED)
	vertical_position += delta*vertical_speed
	
func get_bullet_stats() -> Array:
	rigid_body_2d.position.y = vertical_position
	var spawn_point = bullet_spawn.global_position
	var direction_vec = Vector2(sin(rigid_body_2d.rotation), -cos(rigid_body_2d.rotation))
	
	#print(direction_vec)
	
	return [spawn_point, direction_vec]
	
func _process(delta):
	rigid_body_2d.position.y = vertical_position
	
