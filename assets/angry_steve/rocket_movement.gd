extends Node2D

@onready var sprite: AnimatedSprite2D = $Rocket/RigidBody2D/AnimatedSprite2D
@onready var rigid_body_2d: RigidBody2D = $Rocket/RigidBody2D
@onready var rocket: Node2D = $Rocket
@onready var bullet_spawn: Node2D = $Rocket/RigidBody2D/BulletSpawn
#@onready var timer: Timer = $Rocket/Timer
@onready var area_2d: Area2D = $Area2D
@onready var collision_timer: Timer = $Rocket/collision

const max_velocity: float  = 300
var max_fuel = 0
var boost_speed: float = 500
var impulse = false
var can_move = false

var rotation_speed: float = 200 
@export var vertical_speed = 0
var vertical_position = 0

var max_rotation = deg_to_rad(60)
var min_rotation = deg_to_rad(-60)

# Called when the node enters the scene tree for the first time.
func _ready():
	vertical_speed = 0

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("move_left") and !(rigid_body_2d.rotation < min_rotation) and can_move:
		rigid_body_2d.apply_torque_impulse(-rotation_speed)
		
	if Input.is_action_pressed("move_right") and !(rigid_body_2d.rotation > max_rotation) and can_move:
		rigid_body_2d.apply_torque_impulse(rotation_speed)
			
	if rigid_body_2d.angular_velocity < 0 and rigid_body_2d.rotation < min_rotation:
		rigid_body_2d.angular_velocity = 0
	elif rigid_body_2d.angular_velocity > 0 and rigid_body_2d.rotation > max_rotation:
		rigid_body_2d.angular_velocity = 0

		
	var direction_vec = Vector2(sin(rigid_body_2d.rotation), -cos(rigid_body_2d.rotation))
	rigid_body_2d.apply_force(direction_vec*boost_speed)
	vertical_position += delta*vertical_speed
	
	if rigid_body_2d.linear_velocity.x > max_velocity:
		rigid_body_2d.linear_velocity.x = max_velocity
	
	if rigid_body_2d.linear_velocity.x < -max_velocity:
		rigid_body_2d.linear_velocity.x = -max_velocity

func reset_steve():
	rigid_body_2d.global_position = Vector2(0, 0)
	rigid_body_2d.linear_velocity = Vector2(0, 0)
	rigid_body_2d.angular_velocity = 0
	rigid_body_2d.rotation = 0
	vertical_position = 0
	vertical_speed = 0
	can_move = false
	#rigid_body_2d.rotation
	
func start_steve(linear_speed, angular_speed):
	rigid_body_2d.global_position = Vector2(0, 0)
	rigid_body_2d.linear_velocity = Vector2(0, 0)
	rigid_body_2d.angular_velocity = 0
	rigid_body_2d.rotation = 0
	#rigid_body_2d.angular_velocity = Vector2(0, 0)
	rotation_speed = angular_speed
	boost_speed = linear_speed
	vertical_speed = -150
	can_move = true

func get_bullet_stats() -> Array:
	rigid_body_2d.position.y = vertical_position
	
	var spawn_point = bullet_spawn.global_position
	var direction_vec = Vector2(sin(rigid_body_2d.rotation), -cos(rigid_body_2d.rotation))
	
	return [spawn_point, direction_vec]
	
func bounce_off(bounce_amount: int):
	var bounce_direction = Vector2(-rigid_body_2d.linear_velocity.x, 0)
	rigid_body_2d.apply_force(bounce_direction*bounce_amount)

func _process(delta):
	rigid_body_2d.position.y = vertical_position
	
	if (rigid_body_2d.position.x > 550 or rigid_body_2d.position.x < -550) and !impulse:
		collision_timer.start()
		impulse = true
		bounce_off(120)
	
	area_2d.position = rigid_body_2d.position
	area_2d.rotation = rigid_body_2d.rotation 
	
	
func get_rigid_position():
	return Vector2(0, vertical_position)

func _on_timer_timeout() -> void:
	pass # Replace with function body.


func _on_collision_timeout() -> void:
	impulse = false
