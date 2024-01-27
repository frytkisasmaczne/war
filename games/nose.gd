extends Node2D

@export var brudy: Array[PackedScene]

var center: Vector2
var circle: CircleShape2D
var rng: RandomNumberGenerator

signal seppuku(brud: Node2D)

# Called when the node enters the scene tree for the first time.
func _ready():
	seppuku.connect(sudoku)
	rng = RandomNumberGenerator.new()
	center = $Area2D/CollisionShape2D.position
	circle = $Area2D/CollisionShape2D.shape
	var radius = circle.radius
	print(center, radius)
	for i in range(4):
		var x = center.x + rng.randf_range(-radius, radius)
		var y = center.y + rng.randf_range(-radius, radius)
		var brudpos = Vector2(x, y)
		if (center - brudpos).length() < radius:
			brudy.shuffle()
			var brud: Node2D = brudy[0].instantiate()
			brud.position += brudpos
			$brudy.add_child(brud)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func sudoku(brud: Node2D):
	brud.queue_free()
	var left = $brudy.get_child_count()
	print(left, "zostal brudow")
	if 1 == left:
		winek()


func winek():
	$AnimationPlayer.play("zoomout")
	await $AnimationPlayer.animation_finished
	await get_tree().create_timer(1).timeout
	$"../../..".end.emit(true)
