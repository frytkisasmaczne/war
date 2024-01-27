extends Node2D

@export var quotes: Array[PackedScene]

var result = true
var label: RichTextLabel
var pulsing: String
var donelen = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# regex.compile(".+\\[pulse\\].+\\[/pulse\\]")
	$AnimationPlayer.play("type")
	quotes.shuffle()
	$typewriter/textinside.add_child(quotes[0].instantiate())
	label = $typewriter/textinside.get_child(0)
	var start = label.text.find("[")
	donelen = start
	pulsing = label.text.substr(start+7, label.text.length()-start-15)
	print(pulsing)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


var lastkeycode = -1
func _input(event):
	if event is InputEventKey and not event.pressed:
		lastkeycode = -1

	if event is InputEventKey and event.pressed and event.keycode != lastkeycode and pulsing.length() != 0:
		lastkeycode = event.keycode
		$AnimationPlayer.play("type")
		#tw animation
		label.position.x += -30
		print(event.as_text(), pulsing[0])

		var input = event.as_text().to_lower()
		if event.keycode in [KEY_CTRL, KEY_SHIFT, KEY_ALT]:
			return
		if event.keycode == KEY_SPACE:
			input = " "
			
		if input == pulsing[0].to_lower():
			label.text = label.text.substr(0, donelen) + pulsing[0]
			donelen = label.text.length()
		else:
			label.text = label.text.substr(0, donelen) + "[color=#ff0000]" + pulsing[0] + "[/color]"
			donelen = label.text.length()
			result = false
		pulsing = pulsing.substr(1)
		label.text = label.text + pulsing

		if pulsing.length() == 0:
			if result:
				winek()
			else:
				$"../../..".end.emit(false)


func winek():
	$AnimationPlayer.play("you")
	await $AnimationPlayer.animation_finished
	await get_tree().create_timer(1).timeout
	$"../../..".end.emit(true)
