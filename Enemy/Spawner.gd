extends Node2D

const MIN_SPAWN_TIME = 1.5

var preloadedEnemies := [
	preload("res://Enemy/FastEnemy.tscn"),
	preload("res://Enemy/SlowShooter.tscn"),
	preload("res://Enemy/BouncerEnemy.tscn")
]

var plAsteroid := preload("res://Asteroid/Asteroid.tscn")

onready var spawnTimer := $SpawnTimer

var nextSpawnTime := 5.0

func _ready():
	randomize()
	spawnTimer.start(nextSpawnTime)

func _on_SpawnTimer_timeout():
	#spawn
	var viewRect := get_viewport_rect()
	var randX := rand_range(viewRect.position.x, viewRect.end.x)
	
	if randf() < 0.1:
		var asteroid: Asteroid = plAsteroid.instance()
		asteroid.position = Vector2(randX, position.y)
		get_tree().current_scene.add_child(asteroid)
	else:
		var enemyPreload = preloadedEnemies[randi() % preloadedEnemies.size()]
		var enemy: Enemy = enemyPreload.instance()
		enemy.position = Vector2(randX, position.y)
		get_tree().current_scene.add_child(enemy)
	
	#restart timer
	nextSpawnTime -= 0.1
	if nextSpawnTime < MIN_SPAWN_TIME:
		nextSpawnTime = MIN_SPAWN_TIME
	spawnTimer.start(nextSpawnTime)
