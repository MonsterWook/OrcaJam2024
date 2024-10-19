extends CharacterBody2D

@export var shake_speed : float = 5
@export var value : int = 100

var time : float
var scrap_ui : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	#connect scrap collected to ui system. talk to Aidan about that
	scrap_ui = get_tree().get_first_node_in_group("scrap_ui")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	shake()

func shake():
	rotation = get_sine() 

func get_sine():
	return (sin(time * shake_speed) * .25) + PI/6

func _on_area_2d_area_entered(area : Area2D):
	if(area.is_in_group("player")):
		scrap_ui.increase_scrap_amount(value)
		#play particles or sum
		queue_free()
