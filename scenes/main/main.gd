extends Node2D


func _ready() -> void:
	var os = OS.get_name().to_lower()

	if os == 'android' or os == 'ios':
		add_child(load("res://scenes/ui/touchscreen_input/touchscreen_input.tscn").instantiate())
	
	var camera_border = $camera_border.get_rect()
	$Map.init(camera_border)
