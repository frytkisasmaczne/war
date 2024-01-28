extends Node2D

@export var gaymes: Array[PackedScene]
@export var rotato: VideoStreamTheora
@export var fail: VideoStreamTheora
@export var succ: VideoStreamTheora
@export var playTextNoHover: CompressedTexture2D
@export var playTextOnHover: CompressedTexture2D
@export var creditsTextNoHover: CompressedTexture2D
@export var creditsTextOnHover: CompressedTexture2D
@export var fleeTextNoHover: CompressedTexture2D
@export var fleeTextOnHover: CompressedTexture2D

const GAME_OVER = preload("res://assets/GameOver.ogv")

signal end(result: bool)
var score = 0
var hp = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	end.connect(game_finished)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	$curtain/AnimationPlayer.play("curtain")
	await $curtain/AnimationPlayer.animation_finished
	$Control.visible = false
	gaymes.shuffle()
	for i in range($game/actualgame.get_child_count()):
		$game/actualgame.get_child(i).queue_free()
	$transitions/VideoStreamPlayer.stream = rotato
	$transitions/VideoStreamPlayer.visible = true
	$transitions/VideoStreamPlayer.play()
	$curtain/AnimationPlayer.play_backwards("curtain")
	await $curtain/AnimationPlayer.animation_finished
	var insta = gaymes[0].instantiate()
	await $transitions/VideoStreamPlayer.finished
	$transitions/VideoStreamPlayer.visible = false
	$game/actualgame.add_child(insta)


func game_finished(result):
	$curtain/AnimationPlayer.play("curtain")
	await $curtain/AnimationPlayer.animation_finished
	for i in range($game/actualgame.get_child_count()):
		$game/actualgame.get_child(i).queue_free()
	
	if result:
		score += 1
		$transitions/VideoStreamPlayer.stream = succ
		$transitions/VideoStreamPlayer.visible = true
		$transitions/VideoStreamPlayer.play()
		$transitions/VideoStreamPlayer/score.text = str(score)
	else:
		$transitions/VideoStreamPlayer.stream = fail
		$transitions/VideoStreamPlayer.visible = true
		$transitions/VideoStreamPlayer.play()
		hp -= 1
		if hp == 2:
			$transitions/VideoStreamPlayer/maski/Sprite2D3.texture = load("res://assets/Mask_Failure.png")
			$transitions/VideoStreamPlayer/maski/Sprite2D3.modulate.a = 0.5
		elif hp == 1:
			$transitions/VideoStreamPlayer/maski/Sprite2D2.texture = load("res://assets/Mask_Failure.png")
			$transitions/VideoStreamPlayer/maski/Sprite2D2.modulate.a = 0.5
		elif hp <= 0:
			$transitions/VideoStreamPlayer/maski/Sprite2D.texture = load("res://assets/Mask_Failure.png")
			$transitions/VideoStreamPlayer/maski/Sprite2D.modulate.a = 0.5
			gameend()
			return
	$curtain/AnimationPlayer.play_backwards("curtain")
	await $curtain/AnimationPlayer.animation_finished
	await $transitions/VideoStreamPlayer.finished
	$transitions/VideoStreamPlayer.stream = rotato
	$transitions/VideoStreamPlayer.visible = true
	$transitions/VideoStreamPlayer.play()
	gaymes.shuffle()
	var insta = gaymes[0].instantiate()
	await $transitions/VideoStreamPlayer.finished
	$transitions/VideoStreamPlayer.visible = false
	$game/actualgame.add_child(insta)

func gameend():
	$curtain/AnimationPlayer.play_backwards("curtain")
	await $curtain/AnimationPlayer.animation_finished
	$transitions/VideoStreamPlayer.stream = GAME_OVER
	$transitions/VideoStreamPlayer.visible = true
	$transitions/VideoStreamPlayer.play()
	await $transitions/VideoStreamPlayer.finished
	get_tree().quit()

func _on_play_mouse_entered():
	$Control/TextureRect/play.icon = playTextOnHover

func _on_play_mouse_exited():
	$Control/TextureRect/play.icon = playTextNoHover


func _on_credits_mouse_entered():
	$Control/TextureRect/credits.icon = creditsTextOnHover


func _on_credits_mouse_exited():
	$Control/TextureRect/credits.icon = creditsTextNoHover


func _on_flee_mouse_entered():
	$Control/TextureRect/flee.icon = fleeTextOnHover


func _on_flee_mouse_exited():
	$Control/TextureRect/flee.icon = fleeTextNoHover



func _on_flee_pressed():
	get_tree().quit()


func _on_back_pressed():
	$Control/Popup.visible = false


func _on_credits_pressed():
	$Control/Popup.visible = true
