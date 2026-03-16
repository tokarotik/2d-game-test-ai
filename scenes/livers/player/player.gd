extends "res://scenes/livers/_base/_base.gd"

@onready var camera = $Camera2D

var SPEED = 250

func _ready() -> void:
	super._ready()

func _process(_e) -> void:
	var input = get_keyboard_input()
	
	var vel = input * SPEED
	velocity = vel
	move_and_slide()

func set_camera_borders(level_rect: Rect2) -> void:
	camera.limit_left = level_rect.position.x
	camera.limit_top = level_rect.position.y
	camera.limit_right = level_rect.position.x + level_rect.size.x
	camera.limit_bottom = level_rect.position.y + level_rect.size.y

func get_keyboard_input() -> Vector2:
	var input = Vector2.ZERO
	input.x = Input.get_axis("left", "right")
	input.y = Input.get_axis("up", "down")
	return input
