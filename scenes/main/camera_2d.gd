extends Camera2D

func _ready() -> void:
	$"../Label".visible = false

func enable():
	enabled = true
	$"../Label".visible = true
