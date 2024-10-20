extends Node2D

const bullet = preload("res://assets/angry_steve/bullet.tscn")
@onready var rocket_movement: Node2D = $RocketMovement
@onready var shoot_timeout: Timer = $shootTimeout
@onready var bullets_count: Label = $SceneObjects/BulletsCount
@onready var fuel_bar: ProgressBar = $SceneObjects/FuelBar
@onready var scene_objects: Node2D = $SceneObjects

var can_shoot = true
var reload_time = 1.0
var magazine_size = 5
var fuel_amount = 100
var toughness_percent = 1
var magazine_amount = magazine_size

var fuel_loss_rate = 0.5

var left_barrier = -100
var right_barrier = 100

func _init():
	pass

func _ready():
	fuel_bar.max_value = fuel_amount
	bullets_count.text = "bullets: " + str(magazine_amount) + "/" + str(magazine_size)


func _process(delta: float) -> void:
	# if the shoot butten is pressed spawn bullet at the gun spawn point with the
	# movement direction of the rotation of the rocket
	if Input.is_action_just_pressed("boost") and can_shoot:
		
		if (magazine_amount < 1):
			magazine_amount = magazine_size
			can_shoot = false
			shoot_timeout.start()
		else:
			var result = rocket_movement.get_bullet_stats()	
			var instance = bullet.instantiate()
			instance.position = result[0]
			instance.direction_vec = result[1]
			var bullet_rotation = result[1].angle() - deg_to_rad(90)
			instance.rotation = bullet_rotation
			add_child(instance)
			
			magazine_amount -= 1
			bullets_count.text = "bullets: " + str(magazine_amount) + "/" + str(magazine_size)
			
	if Input.is_action_just_pressed("bounce"):
		take_damage(20)
		
	var rigid_body_position = rocket_movement.get_rigid_position()
	scene_objects.position = rigid_body_position
	
	fuel_amount -= delta*fuel_loss_rate
	fuel_bar.set_value(fuel_amount)
		
func take_damage(damage):
	fuel_amount -= damage*toughness_percent
	rocket_movement.bounce_off(100)
	fuel_bar.set_value(fuel_amount)
	print(fuel_amount)

func _on_timer_timeout() -> void:
	print("can shoot again")
	bullets_count.text = "bullets: " + str(magazine_amount) + "/" + str(magazine_size)
	can_shoot = true
