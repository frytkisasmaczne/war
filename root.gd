extends Node2D

@export var gaymes: Array[PackedScene]

signal end(result: bool)

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
	print(len(gaymes))
	gaymes.shuffle()
	for i in range($game/actualgame.get_child_count()):
		$game/actualgame.get_child(i).queue_free()
	$game/actualgame.add_child(gaymes[0].instantiate())
	# $ui.visible = false
	
	$curtain/AnimationPlayer.play_backwards("curtain")
	await $curtain/AnimationPlayer.animation_finished


func game_finished(result):
	print("what")
	if result:
		print("hello happy world")
	else:
		print("goodbye sad world")
	_on_button_pressed()
