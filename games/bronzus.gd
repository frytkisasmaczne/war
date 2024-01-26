extends Node2D


var goal_pet = 5000
var total_pet = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var lastmousepos = Vector2.ZERO
func _input(event):
	if event is InputEventMouseMotion:
		if intersects(event.position, $Area2D/CollisionShape2D):
			total_pet += (event.position - lastmousepos).length()
			lastmousepos = event.position
			print(total_pet)


func intersects(point: Vector2, box: CollisionShape2D):
	var top = box.position.y - box.get_shape().get_extents().y
	var bottom = box.position.y + box.get_shape().get_extents().y
	var left = box.position.x - box.get_shape().get_extents().x
	var right = box.position.x + box.get_shape().get_extents().x
	if point.x > left and point.x < right and point.y > top and point.y < bottom:
		return true
	return false