extends Node2D

@export var gaymes: Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	# $curtain/AnimationPlayer.play_backwards("curtain")
	
	$curtain/AnimationPlayer.play_backwards("curtain")
	await $curtain/AnimationPlayer.animation_finished
	print(len(gaymes))
	gaymes.shuffle()
	if $game/actualgame.get_child(0):
		$game/actualgame.get_child(0).queue_free()
	$game/actualgame.add_child(gaymes[0].instantiate())
	# $ui.visible = false
	
	$curtain/AnimationPlayer.play("curtain")
	await $curtain/AnimationPlayer.animation_finished
