extends Node2D

@export var gaymes: Array[PackedScene]
@export var rotato: VideoStreamTheora
@export var fail: VideoStreamTheora
@export var succ: VideoStreamTheora
signal end(result: bool)
var hp = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	end.connect(game_finished)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	$curtain/AnimationPlayer.play("curtain")
	await $curtain/AnimationPlayer.animation_finished
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
		$transitions/VideoStreamPlayer.stream = succ
		$transitions/VideoStreamPlayer.visible = true
		$transitions/VideoStreamPlayer.play()
	else:
		$transitions/VideoStreamPlayer.stream = fail
		$transitions/VideoStreamPlayer.visible = true
		$transitions/VideoStreamPlayer.play()
		hp -= 1
		if hp <= 0:
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
	$transitions/VideoStreamPlayer.stream = rotato
