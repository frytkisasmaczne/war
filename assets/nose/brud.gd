extends Node2D

var goal_pet = 1000
var total_pet = 0
var mouse_petting = false
var lastmousepos = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport:Node, event:InputEvent, shape_idx:int):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if Vector2.ZERO != lastmousepos:
			total_pet += (event.position - lastmousepos).length()
			total_pet = clampf(total_pet, 0, goal_pet)
		lastmousepos = event.position
		$Sprite2D.modulate.a = 1 - total_pet/goal_pet
		if total_pet >= goal_pet:
			$"../..".seppuku.emit(self)
		print(total_pet)
