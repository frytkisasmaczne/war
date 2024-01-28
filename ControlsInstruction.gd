extends Node2D

const CONTROLS_INSTRUCTION_SPACE = preload("res://assets/ControlsInstruction/ControlsInstruction_Space.png")
const CONTROLS_INSTRUCTION_MOUSE = preload("res://assets/ControlsInstruction/ControlsInstruction_Mouse.png")
const CONTROLS_INSTRUCTION_KEYBOARD = preload("res://assets/ControlsInstruction/ControlsInstruction_Keyboard.png")

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

@export var instruction_id: int = 0

func _ready():
	match instruction_id:
		0:
			changeSprite(CONTROLS_INSTRUCTION_SPACE)
		1:
			changeSprite(CONTROLS_INSTRUCTION_MOUSE)
		2:
			changeSprite(CONTROLS_INSTRUCTION_KEYBOARD)
		_:
			print("Control Instruction not found, bruh.")
	
	animation_player.play("InstructionZOOM")

func changeSprite(sprite):
	sprite_2d.texture = sprite
