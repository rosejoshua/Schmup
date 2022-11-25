extends Area2D
class_name Asteroid

var pMeteorEffect := preload("res://Asteroid/AsteroidEffect.tscn")

export var minSpeed: float = 50
export var maxSpeed: float = 100
export var minRotationRate: float = -20
export var maxRotationRate: float = 20

export var health: int = 20

var speed: float = 0
var rotationRate: float = 0
var playerInArea: Player = null

func _ready():
	randomize()
	speed = rand_range(minSpeed, maxSpeed)
	rotationRate = rand_range(minRotationRate, maxRotationRate)

func _process(delta):
	if playerInArea != null:
		playerInArea.damage(1)

func _physics_process(delta):
	rotation_degrees += rotationRate * delta
	position.y += speed * delta

func damage(amount: int):
	if health <=0:
		return
	
	health -= amount
	if health <= 0:
		var effect :=pMeteorEffect.instance()
		effect.position = position
		get_parent().add_child(effect)
		Signals.emit_signal("on_score_increment", 50)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Asteroid_area_entered(area):
	if area is Player:
		playerInArea = area

func _on_Asteroid_area_exited(area):
	if area is Player:
		playerInArea = null
