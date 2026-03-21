extends CharacterBody2D

signal death_call

@export var maxLenghtDamage: float = 63
@export var damage: float = 0.0
@export var maxHealth: float = 10.0
var health: float = 0.0:
	set(value):
		health = value
		$ProgressBar.value = value
		if value <= 0.0:
			death_call.emit()
	get:
		return health

func _ready() -> void:
	$attack/node/ColorRect.visible = false
	$ProgressBar.max_value = maxHealth
	$typeTeamArea.name = str(get_groups()[0])
	
	health = maxHealth

func _physics_process(_delta: float) -> void:
	$attack.rotation = atan2(velocity.y, velocity.x) + 1.5708

func set_attack_rotation(attack_rotation: float) -> void:
	$attack.rotation = attack_rotation

func set_attack_y(y: float) -> void:
	$attack/node.position.y = -clamp(y, 0, maxLenghtDamage)

func attack() -> void:
	$attack.attack.emit()
	
	$attack/node/ColorRect.visible = true
	await get_tree().create_timer(0.1).timeout
	$attack/node/ColorRect.visible = false
	
func _accept_damage(_damage: float) -> void:
	health -= _damage

func _on_death() -> void:
	queue_free()
