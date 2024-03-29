extends Node2D

@export var quotes: Array[PackedScene]

var result = true
var label: RichTextLabel
var pulsing: String
var donelen = 0
var timer: Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("type")
	quotes.shuffle()
	$typewriter/kartka/textinside.add_child(quotes[0].instantiate())
	label = $typewriter/kartka/textinside.get_child(0)
	var start = label.text.find("[")
	donelen = start
	pulsing = label.text.substr(start+7, label.text.length()-start-15)
	print(pulsing)
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(lose)
	timer.start(10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $timer.text != "":
		$timer.text = str(int(timer.time_left))


var lastkeycode = -1
func _input(event):
	if event is InputEventKey and not event.pressed:
		lastkeycode = -1

	if event is InputEventKey and event.pressed and event.keycode != lastkeycode and pulsing.length() != 0:
		lastkeycode = event.keycode
		var input = event.as_text().to_lower()
		if event.keycode in [KEY_CTRL, KEY_SHIFT, KEY_ALT]:
			return
		if event.keycode == KEY_SPACE:
			input = " "
		$AnimationPlayer.play("type")
		$typewriter/kartka.position.x += -30
		print(event.as_text(), pulsing[0])

		
			
		if input == pulsing[0].to_lower():
			label.text = label.text.substr(0, donelen) + pulsing[0]
			donelen = label.text.length()
		else:
			label.text = label.text.substr(0, donelen) + "[color=#ff0000]" + pulsing[0] + "[/color]"
			donelen = label.text.length()
			result = false
		pulsing = pulsing.substr(1)
		label.text = label.text + "[pulse]" + pulsing + "[/pulse]"

		if pulsing.length() == 0:
			if result:
				winek()
			else:
				lose()


func lose():
	$"../../..".end.emit(false)


func winek():
	$timer.text = ""
	timer.stop()
	$AnimationPlayer.play("you")
	await $AnimationPlayer.animation_finished
	await get_tree().create_timer(1).timeout
	$"../../..".end.emit(true)
