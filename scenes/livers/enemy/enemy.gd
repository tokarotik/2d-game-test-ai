extends "res://scenes/livers/_base/_base.gd"

const SPEED = 200
const DISTANCE: float = 30
const TARGETS_LIST = ['player', 'ai']

var minRandom := Vector2(0,0)
var maxRandom := Vector2(100,100)

var target
var random_direction

@onready var timers = $timers
var rng := RandomNumberGenerator.new()

func _ready() -> void:
	super._ready()
	rng.randomize()

func _on_area_2d_area_entered(area: Area2D) -> void:
	var tname = area.name
	#print(tname, " has entered in visibility area of ", name)
	if target == null:
		if tname in TARGETS_LIST:
			target = area.get_parent()

func _process(_delta: float) -> void:
	move_and_slide()

func set_camera_borders(level_rect: Rect2) -> void:
	minRandom = Vector2(level_rect.position.x, level_rect.position.y)
	maxRandom = Vector2(level_rect.position.x + level_rect.size.x,
						level_rect.position.y + level_rect.size.y
	)

func _physics_process(_delta):
	if target:
		var direction: Vector2 = target.global_position - global_position
		go_direction(direction)

	else:
		if random_direction == null:
			random_direction = get_random_direction()
			
			var timer = Timer.new()
			timers.add_child(timer)
			timer.timeout.connect(_timeout.bind(timer))
			
			timer.start(3)
			
		go_direction(random_direction, false)

func go_direction(direction: Vector2, to_attack: bool = true) -> void:
	var dist = abs(DISTANCE - (abs(direction.x) + abs(direction.y)))
	
	set_attack_rotation(atan2(direction.y, direction.x) + 1.5708)
	set_attack_y(direction.length())
	
	if dist <= 62.5 and to_attack: attack()
	if dist <= DISTANCE: 
		velocity = velocity * 0.9
		
	else:

		# accelerate toward direction
		velocity += direction.normalized() * SPEED

		# clamp speed so it doesn't grow forever
		velocity = velocity.limit_length(SPEED)

func get_random_direction() -> Vector2:
	var _random_direction = _get_random_coords() - global_position
	return _random_direction

func _timeout(timer: Timer):
	timer.queue_free()
	random_direction = null
	
func _get_random_coords() -> Vector2:
	rng.randomize()
	return Vector2(_get_rand_x(),_get_rand_y())

func _get_rand_x() -> int:
	return rng.randi_range(minRandom.x, maxRandom.x)

func _get_rand_y() -> int:
	return rng.randi_range(minRandom.y, maxRandom.y)
