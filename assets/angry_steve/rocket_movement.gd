extends Node2D

const ROTATION_SPEED: float = 5
const BOOST_SPEED: float = 500
@onready var rocket: Node2D = $Rocket
@onready var rigid_body_2d: RigidBody2D = $Rocket2/RigidBody2D
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
	print(rigid_body_2d.angular_velocity)
	#print(rigid_body_2d.rotation)
		
	#elif rigid_body_2d.rotation > max_rotation or rigid_body_2d.rotation < min_rotation:
	if (Input.is_action_pressed("boost")):
		print("BOOST")
		var direction_vec = Vector2(sin(rigid_body_2d.rotation), -cos(rigid_body_2d.rotation))
		#rigid_body_2d.apply_force(Vector2(0, -1)*BOOST_SPEED)
		rigid_body_2d.apply_force(direction_vec*BOOST_SPEED)
		print(direction_vec)
		
	#if absrotation) > max_rotation:
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rigid_body_2d.position.y = 0
	
	
	# get the direction vector of the rocket and use it as the force vector
