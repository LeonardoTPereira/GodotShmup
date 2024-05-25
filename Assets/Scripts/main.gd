extends Node2D
class_name Spawner

signal enemySpawned
@export var spawn_list: SpawnList
@export var spawner_list: Array[Marker2D]
var game_over_scene: PackedScene
var current_spawn_index: int
var total_spawners: int


func _init():
	game_over_scene = load("res://Assets/Scenes/game_over.tscn")
	current_spawn_index = 0


func _ready():
	total_spawners = spawner_list.size()
	print("Spawners: "+ str(total_spawners))
	$Player.gameOver.connect(_on_game_over)


func _on_timer_timeout():
	if current_spawn_index >= spawn_list.enemy_formations.size():
		return
	var formation = spawn_list.enemy_formations[current_spawn_index]
	spawner_list.shuffle()
	var total_spawns = 0
	for enemy_type_index in range(formation.enemy_count.size()):
		await get_tree().create_timer(0.5).timeout
		for enemy_index in range(formation.enemy_count[enemy_type_index]):
			var enemy = formation.enemy_list[enemy_type_index].instantiate() as Enemy
			enemy.position = spawner_list[total_spawns%total_spawners].position
			add_child(enemy)
			enemySpawned.emit(enemy)
			total_spawns+=1
	current_spawn_index+=1
	$SpawnTimer.start()


func _on_game_over():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_packed(game_over_scene)
