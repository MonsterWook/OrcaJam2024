extends Node2D

const bullet = preload("res://assets/angry_steve/bullet.tscn")
@onready var rocket_movement: Node2D = $RocketMovement
@onready var shoot_timeout: Timer = $shootTimeout
@onready var fuel_bar: ProgressBar = $RocketMovement/FuelBar

var can_shoot = true
var reload_time = 1.0
var magazine_size = 5
var fuel_amount = 100
var toughness_percent = 1
var magazine_amount = magazine_size

var left_barrier = -100
var right_barrier = 100

func _init():
	pass

func _ready():
	fuel_bar.max_value = fuel_amount


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
			add_child(instance)
			magazine_amount -= 1
			
	if Input.is_action_just_pressed("bounce"):
		#print("bounce")
		take_damage(20)
		
		
func take_damage(damage):
	fuel_amount -= damage*toughness_percent
	rocket_movement.bounce_off(10000)
	fuel_bar.set_value(fuel_amount)
	print(fuel_amount)

func _on_timer_timeout() -> void:
	print("can shoot again")
	can_shoot = true
