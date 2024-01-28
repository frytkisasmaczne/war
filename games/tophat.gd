extends Node2D

@onready var lAnimPla = $hats/change_left as AnimationPlayer
@onready var mAnimPla = $hats/change_middle as AnimationPlayer
@onready var rAnimPla = $hats/change_right as AnimationPlayer

@onready var jAnimPla = $jester/jester_shuffle as AnimationPlayer
@onready var sAnimPla = $onehand/start_anim as AnimationPlayer

@onready var win = $prize/win_anim as AnimationPlayer

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

var notDone = true 

# Called when the node enters the scene tree for the first time.
func _ready():
	%hands.visible = false
	get_node("thumbs/up").visible = false
	get_node("thumbs/down").visible = false
	get_node("prize/GirlL").visible = false
	get_node("prize/GirlL").visible = false
	get_node("prize/RabbitL").visible = false
	get_node("prize/GirlM").visible = false
	get_node("prize/RabbitM").visible = false
	get_node("prize/GirlR").visible = false
	get_node("prize/RabbitR").visible = false
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
	var scale = 5
	for n in range(30):
		scale = scale - .4
		if (scale <= 1):
			scale = 1.3
		play_mix_animation(choose_random_hat())
		lAnimPla.set_speed_scale(1/scale)
		mAnimPla.set_speed_scale(1/scale)
		rAnimPla.set_speed_scale(1/scale)
		await get_tree().create_timer(0.2*scale).timeout
		lAnimPla.stop()
		mAnimPla.stop()
		rAnimPla.stop()
	jAnimPla.stop()
	%hands.visible = false
	get_node("showhands").visible = true
	print(Hat)
	notDone = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func endMyLife(where):
	if (Hat[where] == "MIDDLE"): #wygrna
		get_node("showhands").visible = false
		get_node("thumbs/up").visible = true
		get_node("thumbs/down").visible = false
		await get_tree().create_timer(1).timeout
		win.play("win")
		match where:
			0:
				get_node("prize/GirlL").visible = true
				get_node("prize/RabbitL").visible = true
			1:
				get_node("prize/GirlM").visible = true
				get_node("prize/RabbitM").visible = true
			2:
				get_node("prize/GirlR").visible = true
				get_node("prize/RabbitR").visible = true
		await get_tree().create_timer(1).timeout
		$"../../..".end.emit(true)
	else: #przegrana
		#notDone = true #odkomentuj jak chcesz żeby tylko pierwszy wybór się liczył
		get_node("showhands").visible = false
		get_node("thumbs/up").visible = false
		get_node("thumbs/down").visible = true
		await get_tree().create_timer(1).timeout
		$"../../..".end.emit(false)

func _on_left_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.button_index == 1 and event.pressed and !notDone):
		endMyLife(0)

func _on_middle_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.button_index == 1 and event.pressed and !notDone):
		endMyLife(1)

func _on_right_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.button_index == 1 and event.pressed and !notDone):
		endMyLife(2)
