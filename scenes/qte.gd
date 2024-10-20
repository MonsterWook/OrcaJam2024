extends Node2D

@export var duration : float = 7
@export var amount_needed : int = 20

@onready var cutscene = $AnimatedSprite2D
@onready var anim = $AnimationPlayer
@onready var space_bar = $space_bar

var qte_active : bool = false
var mash_button : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("before")

func start_qte():
	qte_active = true
	anim.stop()
	space_bar.visible = true
	cutscene.play("qte")
	anim.play("qte")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	print("win")
	anim.stop()
	space_bar.visible = false

func qte_fail():
	mash_button = 0
	qte_active = false
	print("lose")
	anim.stop()
	space_bar.visible = false
