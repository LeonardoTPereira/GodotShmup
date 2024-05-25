extends Control

@export var player: Player
@export var spawner: Spawner

# Called when the node enters the scene tree for the first time.
func _ready():
	player.healthChanged.connect(update_health)
	spawner.enemySpawned.connect(listen_to_enemy)
	$ScoreValue.text = str(0)


func update_health(health):
	$HPValue.text = str(health)
	

func listen_to_enemy(enemy):
	enemy.defeated.connect(update_score)	
	
	
func update_score(score):
	$ScoreValue.text = str(int($ScoreValue.text)+score)
