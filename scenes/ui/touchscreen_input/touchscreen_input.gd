extends Node2D

const TOUCHSCREEN_OS := ['android', 'ios']

func _ready() -> void:
	var os = OS.get_name().to_lower()
	if not (os in TOUCHSCREEN_OS):
		$CanvasLayer.visible = false
