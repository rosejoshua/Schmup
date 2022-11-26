extends Area2D
class_name Enemy

var plBullet := preload("res://Bullet/EnemyBullet.tscn")
var plEnemyExplosion := preload("res://Enemy/EnemyExplosion.tscn")
var plShipGib := preload("res://Effects/ShipGib.tscn")

onready var priColor0 := Color(1.0, 0.0, 0.0, 1.0)
onready var secColor0 := Color(0.0, 1.0, 0.0, 1.0)
onready var tertColor0 := Color(0.0, 0.0, 1.0, 1.0)
onready var priColor1 := Color(1.0, 0.0, 0.0, 0.0)
onready var secColor1 := Color(0.0, 1.0, 0.0, 0.0)
onready var tertColor1 := Color(0.0, 0.0, 1.0, 0.0)

onready var firingPositions := $FiringPositions

export var verticalSpeed: float = 10
export var health: int = 5

var playerInArea: Player = null

func setPriColor0 (color: Color):
	priColor0 = color
func setSecColor0 (color: Color):
	secColor0 = color
func setTertColor0 (color: Color):
	tertColor0 = color
func setPriColor1 (color: Color):
	priColor1 = color
func setSecColor1 (color: Color):
	secColor1 = color
func setTertColor1 (color: Color):
	tertColor1 = color

func _process(delta):
	if playerInArea != null:
		playerInArea.damage(1)

func _physics_process(delta):
	position.y += verticalSpeed * delta

func fire():
	for child in firingPositions.get_children():
		var bullet := plBullet.instance()
		bullet.global_position = child.global_position
		get_tree().current_scene.add_child(bullet)

func damage(amount: int):
	if health <=0:
		return
	
	health -= amount
	if health <= 0:
		var explosion := plEnemyExplosion.instance()
		var shipGib1 := plShipGib.instance()
		var shipGib2 := plShipGib.instance()
		var shipGib3 := plShipGib.instance()
		
		shipGib1.color_ramp = Gradient.new()
		shipGib2.color_ramp = Gradient.new()
		shipGib3.color_ramp = Gradient.new()
		
		shipGib1.get_color_ramp().colors[0] = priColor0
		shipGib1.get_color_ramp().colors[1] = priColor1
		shipGib2.get_color_ramp().colors[0] = secColor0
		shipGib2.get_color_ramp().colors[1] = secColor1
		shipGib3.get_color_ramp().colors[0] = tertColor0
		shipGib3.get_color_ramp().colors[1] = tertColor1
		
		explosion.global_position = global_position
		shipGib1.global_position = global_position
		shipGib2.global_position = global_position
		shipGib3.global_position = global_position
		get_tree().current_scene.add_child(explosion)
		get_tree().current_scene.add_child(shipGib1)
		get_tree().current_scene.add_child(shipGib2)
		get_tree().current_scene.add_child(shipGib3)
		Signals.emit_signal("on_score_increment", 100)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Enemy_area_entered(area):
	if area is Player:
		playerInArea = area

func _on_Enemy_area_exited(area):
	if area is Player:
		playerInArea = null
