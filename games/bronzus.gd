extends Node2D

var goal_pet = 5000
var total_pet = 0
var timer: Timer
var lastmousepos = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(lose)
	timer.start(10)


func _process(delta):
	if $timer.text != "":
		$timer.text = str(int(timer.time_left))


func _on_area_2d_input_event(viewport:Node, event:InputEvent, shape_idx:int):
	if Vector2.ZERO != lastmousepos:
		total_pet += (event.position - lastmousepos).length()
		$AnimatedSprite2D.frame = int(int(total_pet)%(50*5)/50)
		if total_pet >= goal_pet and $timer.text != "":
			winek()
	lastmousepos = event.position
	print(total_pet)


func _on_area_2d_mouse_entered():
	$AnimatedSprite2D.visible = true


func _on_area_2d_mouse_exited():
	$AnimatedSprite2D.visible = false


func lose():
	$"../../..".end.emit(false)


func winek():
	$timer.text = ""
	timer.stop()
	await get_tree().create_timer(1).timeout
	$"../../..".end.emit(true)
