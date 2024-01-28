extends Node2D

@export var gaymes: Array[PackedScene]
@export var rotato: VideoStreamTheora
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
	$game/actualgame.add_child(gaymes[0].instantiate())
	await $transitions/VideoStreamPlayer.finished
	$transitions/VideoStreamPlayer.visible = false


func game_finished(result):
	print("what")
	if result:
		print("hello happy world")
	else:
		print("goodbye sad world")
		hp -= 1
		if hp <= 0:
			gameend()
			return
	_on_button_pressed()


func gameend():
	$transitions/VideoStreamPlayer.stream = rotato
