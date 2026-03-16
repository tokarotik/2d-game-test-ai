extends "res://scenes/livers/_base/_base.gd"

const SPEED = 500
const TARGETS_LIST = ['player']

@export var acceleration := 700.0
@export var friction := 100.0
@export var randomness := 1.0

var target

func _on_area_2d_area_entered(area: Area2D) -> void:
	var tname = area.name
	if tname in TARGETS_LIST:
		target = area.get_parent()
	
		await get_tree().create_timer(1).timeout
		#$Area2D.disconnect('area_entered', _on_area_2d_area_entered)
		if $Area2D == null: return
		if $Area2D.is_connected("area_entered", _on_area_2d_area_entered):
			$Area2D.disconnect('area_entered', _on_area_2d_area_entered)
			$Area2D.queue_free()
			
func _physics_process(delta):
	if target:
		var direction = (target.global_position - global_position).normalized()

		direction += Vector2(
			randf_range(-randomness, randomness),
			randf_range(-randomness, randomness)
		)

		direction = direction.normalized()

		# accelerate toward direction
		velocity += direction * acceleration * delta

		# clamp speed so it doesn't grow forever
		velocity = velocity.limit_length(SPEED)

	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	move_and_slide()
