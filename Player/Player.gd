extends Area2D
class_name Player

var plBullet := preload("res://Bullet/Bullet.tscn")

onready var animatedSprite := $AnimatedSprite
onready var firingPositions := $FiringPositions
onready var fireDelayTimer := $FireDelayTimer
onready var invincibilityTimer :=$InvincibilityTimer
onready var shieldSprite := $Shield

export var speed: float = 400
export var fireDelay: float = 0.05
export var life: int = 3
export var damageInvincibilityTime := 1.25
var vel := Vector2(0,0)

func _ready():
	shieldSprite.visible = false
	Signals.emit_signal("on_player_life_changed", life)

func _process(delta):
	if vel.x < 0:
		animatedSprite.play("left")
	elif vel.x > 0:
		animatedSprite.play("right")
	else:
		animatedSprite.play("straight")

func _physics_process(delta):
	var dirVec := Vector2(0,0)

	if Input.is_action_pressed("move_left"):
		dirVec.x = -1
	elif Input.is_action_pressed("move_right"):
		dirVec.x = 1
	if Input.is_action_pressed("move_up"):
		dirVec.y = -1
	elif Input.is_action_pressed("move_down"):
		dirVec.y = 1

	if Input.is_action_pressed("shoot") and fireDelayTimer.is_stopped():
		fireDelayTimer.start(fireDelay)
		for child in firingPositions.get_children():
			var bullet := plBullet.instance()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)


	vel = dirVec.normalized() * speed
	position += vel * delta

	#clamping
	var viewRect := get_viewport_rect()
	position.x = clamp(position.x, viewRect.position.x, viewRect.end.x)
	position.y = clamp(position.y, viewRect.position.y, viewRect.end.y)

func damage(amount: int):
	if !invincibilityTimer.is_stopped():
		return
	
	invincibilityTimer.start(damageInvincibilityTime)
	shieldSprite.visible = true
	life -= amount
	Signals.emit_signal("on_player_life_changed", life)

	var camera := get_tree().current_scene.find_node("Camera", true, false)
	camera.shake(15)
	
	if life <= 0:
		queue_free()

func _on_InvincibilityTimer_timeout():
	shieldSprite.visible = false
