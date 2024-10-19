extends Node2D

@export var obstacle : CharacterBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (obstacle.global_position.x > 10000 ||
		obstacle.global_position.x < -10000 ||
		obstacle.global_position.y > 10000):
			despawn()

func despawn():
	obstacle.queue_free()
