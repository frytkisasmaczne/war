extends Node2D

var timer: Timer
var pumped = 0.0
var waspressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(lose)
	timer.start(10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pumped = clampf(pumped - delta*0.5, 0, 1)
	if $timer.text != "":
		$timer.text = str(int(timer.time_left))
	$reka/AnimatedSprite2D.frame = int(pumped*4)


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			print(pumped)
			pumped = clampf(pumped + 0.2, 0, 1)
			if pumped >= 1 and $timer.text != "":
				winek()


func lose():
	$"../../..".end.emit(false)


func winek():
	$timer.text = ""
	timer.stop()
	$VideoStreamPlayer.play()
	await $VideoStreamPlayer.finished
	$"../../..".end.emit(true)
