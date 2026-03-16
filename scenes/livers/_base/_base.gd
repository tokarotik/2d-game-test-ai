extends CharacterBody2D

"""
@export var texture: Texture2D:
	set(value):
		texture = value
		if $Sprite2D: _set_texture()
	get():
		return texture
func _set_texture():
	$Sprite2D.texture = texture
"""
func _ready() -> void:
	$typeTeamArea.name = str(get_groups()[0])
