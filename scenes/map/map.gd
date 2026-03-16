extends Node2D

@onready var walls = $walls
@onready var enemies = $enemies
@onready var any = $any

@onready var livers = $livers

var PLAYER = preload("res://scenes/livers/player/player.tscn")
var ENEMY = preload("res://scenes/livers/enemy/enemy.tscn")
var PARTICLE = preload("res://scenes/livers/particle/particle.tscn")

func _ready() -> void:
	enemies.visible = false
	any.visible = false

	
func init(cameraBorders: Rect2) -> void:
	spawn_livers()
	
	for i in livers.get_children():
		if i.has_method('set_camera_borders'):
			i.call('set_camera_borders', cameraBorders)

func spawn_livers():
	var any_tiles = get_tiles(any)
	var enemies_tiles = get_tiles(enemies)
	
	_spawnLivers(any_tiles, PLAYER, 1)
	_spawnLivers(any_tiles, PARTICLE, 2)
	_spawnLivers(enemies_tiles, ENEMY, 0)
	
func _spawnLivers(tiles: Dictionary, liverScene: Resource, tile_id: int):
	var tiles_livers = tiles.get(tile_id)
	if tiles_livers == null: return
	
	for coords in tiles_livers:
		_spawnLiver(liverScene, Vector2(coords) * 64)
	
func _spawnLiver(scene: Resource, pos: Vector2) -> void:
	var instance = scene.instantiate()
	
	var instanceName = scene.resource_path.split('/')[-1].split('.')[0]
	
	instance.position = pos
	instance.name = instanceName + str(randi_range(1000, 9999))
	
	livers.add_child(instance)
	
func get_tiles(mapScene: TileMapLayer) -> Dictionary:
	var tiles := {}
	var cells = mapScene.get_used_cells()
	for cell in cells:
		var id = mapScene.get_cell_source_id(cell)
		if not tiles.has(id):
			tiles[id] = []
		
		tiles[id].append(cell)

	return tiles
