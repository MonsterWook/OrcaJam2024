extends Node2D

@export var obstacle : CharacterBody2D

var time : float = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if (obstacle.global_position.x > 2000 ||
		obstacle.global_position.x < -2000 ||
		time > 10):
			despawn()

func despawn():
	obstacle.queue_free()
