extends Node2D

@export var obstacle : CharacterBody2D

var time
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if (obstacle.global_position.x > 2000 ||
		obstacle.global_position.x < -2000 ||
		time > 15):
			despawn()

func despawn():
	obstacle.queue_free()
