extends Node2D

@onready var lAnimPla = $hats/change_left as AnimationPlayer
@onready var mAnimPla = $hats/change_middle as AnimationPlayer
@onready var rAnimPla = $hats/change_right as AnimationPlayer

@onready var jAnimPla = $jester/jester_shuffle as AnimationPlayer

@onready var sAnimPla = $onehand/start_anim as AnimationPlayer

var Hat = ["LEFT", "MIDDLE", "RIGHT"]

func choose_random_hat():
	return randi() % 3

func play_mix_animation(hat):
	match hat:
		0:
			lAnimPla.play("change_left")
			Hat = [Hat[1], Hat[0], Hat[2]]
		1:
			mAnimPla.play("change_middle")
			Hat = [Hat[2], Hat[1], Hat[0]]
		2:
			rAnimPla.play("change_right")
			Hat = [Hat[0], Hat[2], Hat[1]]


# Called when the node enters the scene tree for the first time.
func _ready():
	%hands.visible = false
	get_node("secondhand").visible = true
	await get_tree().create_timer(1.5).timeout
	get_node("secondhand").visible = false
	sAnimPla.play("bunny_drop")
	await get_tree().create_timer(2).timeout
	get_node("onehand/rabbit").visible = false
	%hands.visible = true
	await get_tree().create_timer(1.5).timeout
	randomize()
	jAnimPla.play("shuffle")
	for n in range(80):
		play_mix_animation(choose_random_hat())
		await get_tree().create_timer(0.2).timeout
		lAnimPla.stop()
		mAnimPla.stop()
		rAnimPla.stop()
	jAnimPla.stop()
	print(Hat)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
