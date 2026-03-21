extends Node

signal attack

var target
@onready var teamArea = $"../typeTeamArea"

func _on_attack():
	if target != null:
		target._accept_damage($"..".damage)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if target == null:
		if '_baseTeam' in area.get_groups():
			if area == null: return
			if teamArea == null: return
			if area.name != teamArea.name:
				var tar = area.get_body()
				if tar.name != $"..".name:
					target = tar


func _on_area_2d_area_exited(area: Area2D) -> void:
	if '_baseTeam' in area.get_groups():
		if area.get_body() == target:
			target = null
