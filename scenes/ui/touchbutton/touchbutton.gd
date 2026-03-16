@tool
extends TouchScreenButton

@export var text: String = 'TouchButton':
	set(value):
		text = value
		_set_text()
	get:
		return text
		
func _set_text() -> void:
	if $Label:
		$Label.text = text
