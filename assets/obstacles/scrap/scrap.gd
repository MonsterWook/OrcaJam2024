extends CharacterBody2D

@export var shake_speed : float = 5
@export var value : int = 100

@onready var pickup = $pickup
@onready var collision_shape_2d = $Area2D/CollisionShape2D

var time : float
var scrap_ui : Node
var sfx

var goto_pos : Vector2 = Vector2.ZERO
var spawnedDirection : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	#connect scrap collected to ui system. talk to Aidan about that
	scrap_ui = get_tree().get_first_node_in_group("scrap_ui")
	sfx = get_tree().get_first_node_in_group("sfx")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	shake()
	if(goto_pos != Vector2.ZERO):
		move_to()

func shake():
	rotation = get_sine() 

func move_to():
	if ((global_position - goto_pos) < Vector2(2,2) ||
		(global_position - goto_pos) > Vector2(2,2)):
			var tween = get_tree().create_tween()
			tween.tween_property(self, "global_position", goto_pos, .5)
func get_sine():
	return (sin(time * shake_speed) * .25) + PI/6

func _on_area_2d_area_entered(area : Area2D):
	if(area.is_in_group("player")):
		scrap_ui.increase_scrap_amount(value)
		sfx.play_sound(pickup)
		collision_shape_2d.set_deferred("disabled", true)
		visible = false
