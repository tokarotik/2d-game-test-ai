extends "res://scenes/livers/_base/_base.gd"

@onready var camera = $Camera2D
@onready var cameraOnDeath

var SPEED = 250

func _ready() -> void:
	super._ready()

func _process(_e) -> void:
	#super._process(_e)
	
	var input = get_keyboard_input()
	
	var vel = input * SPEED
	velocity = vel
	move_and_slide()
	
	if Input.is_action_just_pressed("attack"):
		attack()

func _physics_process(_delta: float) -> void:
	var pos: Vector2 = global_position - get_global_mouse_position()
	set_attack_rotation(atan2(pos.y, pos.x) - 1.5708)
	set_attack_y(pos.length())
	
func set_camera_borders(level_rect: Rect2) -> void:
	return
	"""
	camera.limit_left = level_rect.position.x
	camera.limit_top = level_rect.position.y
	camera.limit_right = level_rect.position.x + level_rect.size.x
	camera.limit_bottom = level_rect.position.y + level_rect.size.y
	"""
	
func set_camera_on_death(_cameraOnDeath: Camera2D) -> void:
	cameraOnDeath = _cameraOnDeath
	
func get_keyboard_input() -> Vector2:
	var input = Vector2.ZERO
	input.x = Input.get_axis("left", "right")
	input.y = Input.get_axis("up", "down")
	return input



func _on_death_call() -> void:
	if cameraOnDeath != null:
		cameraOnDeath.enable()
