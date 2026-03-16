extends "res://scenes/livers/_base/_base.gd"

@onready var camera = $Camera2D
@onready var ui = $Control
@onready var buttons_x = [$Control/left, $Control/right]
@onready var buttons_y = [$Control/up, $Control/down]

var SPEED = 250

func _ready() -> void:
	super._ready()
	#ui.reparent(get_tree().get_root().get_children()[0])

func _process(_e) -> void:
	var input = get_keyboard_input()
	if input == Vector2.ZERO:
		input = get_buttons_input()

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
	
func get_buttons_input() -> Vector2:
	var input = Vector2.ZERO
	input.x = get_buttons_axis(buttons_x[0], buttons_x[1])
	input.y = get_buttons_axis(buttons_y[0], buttons_y[1])
	return input

func get_buttons_axis(button2: Button, button1: Button):
	return type_convert(button1.button_pressed, TYPE_INT) - type_convert(button2.button_pressed, TYPE_INT)
