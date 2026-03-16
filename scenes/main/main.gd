extends Node2D


func _ready() -> void:
	
	var camera_border = $camera_border.get_rect()
	$Map.init(camera_border)
