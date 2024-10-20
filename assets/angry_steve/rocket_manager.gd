extends Node2D

const bullet = preload("res://assets/angry_steve/bullet.tscn")
@onready var rocket_movement: Node2D = $RocketMovement
@onready var shoot_timeout: Timer = $shootTimeout
@onready var bullets_count: Label = $SceneObjects/BulletsCount
@onready var fuel_bar: ProgressBar = $SceneObjects/FuelBar
@onready var scene_objects: Node2D = $SceneObjects
@onready var scene_manager: Node = $"../SceneManager"
@onready var scrap_amount: Label = $SceneObjects/ScrapAmount

var cam_shake
var can_shoot = true
var reload_time = 1.0
var magazine_size = 5
var fuel_amount = 100
var max_fuel = (-12000/-100)*6
	
var toughness_percent = 1
var magazine_amount = magazine_size

var fuel_loss_rate = 6

var left_barrier = -100
var right_barrier = 100

func _init():
	pass

func _ready():
	bullets_count.text = "bullets: " + str(magazine_amount) + "/" + str(magazine_size)
	fuel_bar.max_value = max_fuel
	cam_shake = get_tree().get_first_node_in_group("camera_shake")
	print("max speed: " + str(max_fuel))


func _process(delta: float) -> void:
	# if the shoot butten is pressed spawn bullet at the gun spawn point with the
	# movement direction of the rotation of the rocket
	if Input.is_action_just_pressed("boost") and can_shoot:
		
		var result = rocket_movement.get_bullet_stats()	
		var instance = bullet.instantiate()
		instance.position = result[0]
		instance.direction_vec = result[1]
		var bullet_rotation = result[1].angle() - deg_to_rad(90)
		instance.rotation = bullet_rotation
		add_child(instance)
		
		cam_shake.apply_shake(2)
		
		magazine_amount -= 1
		bullets_count.text = "bullets: " + str(magazine_amount) + "/" + str(magazine_size)
		

	if (magazine_amount < 1):
			magazine_amount = magazine_size
			can_shoot = false
			shoot_timeout.start()
			
	if Input.is_action_just_pressed("bounce"):
		take_damage(20)
		
	var rigid_body_position = rocket_movement.get_rigid_position()
	scene_objects.position = rigid_body_position
	
	fuel_amount -= delta*fuel_loss_rate
	fuel_bar.set_value(fuel_amount)
	
	scrap_amount.text = "Scrap: " + str(SceneManager.scrap)
	
	if (fuel_amount < 0):
		get_parent().steve_died()
		rocket_movement.reset_steve()
	
		
func take_damage(damage):
	fuel_amount -= damage*toughness_percent
	rocket_movement.bounce_off(100)
	fuel_bar.set_value(fuel_amount)
	
	

func start():
	#fuel amount
	#speed
	
	#fuel_amount = SceneManager.fuel_max
	magazine_size = 1 + SceneManager.shotgun_lvl
	magazine_amount = magazine_size
	#for rocket management
	fuel_amount = 100 + pow(2,SceneManager.fuel_lvl) * 20
	#fuel_amount = max_fuel
	print("fuel amount " + str(fuel_amount))
	#print("fuel amount: " + str(SceneManager.fuel_max))
	toughness_percent = 1 - (SceneManager.toughness_lvl / 10.0)*0.5
	
	# for rocket movemment
	var linear_speed = 300 + SceneManager.fuel_lvl * 20
	var angular_speed = 400 + SceneManager.tilt_lvl * 20

	#toughness_percent = float(SceneManager.toughness_lvl)
	#fuel_bar.max_value = fuel_amount
	fuel_bar.set_value(fuel_amount)
	rocket_movement.start_steve(linear_speed, angular_speed)

func _on_timer_timeout() -> void:
	print("can shoot again")
	bullets_count.text = "bullets: " + str(magazine_amount) + "/" + str(magazine_size)
	can_shoot = true
