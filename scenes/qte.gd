extends Node2D

@export var duration : float = 7
@export var amount_needed : int = 20

@onready var cutscene = $AnimatedSprite2D
@onready var anim = $AnimationPlayer
@onready var space_bar = $space_bar
@onready var progress_bar = $TextureProgressBar

@onready var explosion = $sfx/Explosion
@onready var rage = $sfx/Rage
@onready var scream = $sfx/Scream

var qte_active : bool = false
var mash_button : int = 0
# Called when the node enters the scene tree for the first time.
func start_anim():
	anim.play("before")

func start_qte():
	scream.play()
	qte_active = true
	space_bar.visible = true
	progress_bar.visible = true
	cutscene.play("qte")
	anim.play("qte")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress_bar.set_value(duration)
	if (mash_button >= amount_needed):
		qte_win()
	elif (qte_active && duration > 0):
		duration -= delta
		if (Input.is_action_just_pressed("boost")):
			mash_button += 1
	elif (qte_active):
		qte_fail()
func qte_win():
	mash_button = 0
	qte_active = false
	space_bar.visible = false
	progress_bar.visible = false
	anim.play("win")

func qte_fail():
	mash_button = 0
	qte_active = false
	space_bar.visible = false
	progress_bar.visible = false
	cutscene.play("fail")
	anim.play("fail")

func quit_game():
	get_tree().quit()

func restart_game():
	get_tree().get_first_node_in_group("real_player").take_damage(1000000000)
