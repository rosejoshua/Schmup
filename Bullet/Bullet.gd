extends Area2D

var pBulletEffect := preload("res://Bullet/BulletEffect.tscn")

export var speed: float = 2000

func _physics_process(delta):
	position.y -= speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_area_entered(area):
	if area.is_in_group("damageable"):
		var bulletEffect := pBulletEffect.instance()
		bulletEffect.position = position
		get_parent().add_child(bulletEffect)
		
#		var camera := get_tree().current_scene.find_node("Camera", true, false)
#		camera.shake(1)
		
		area.damage(1)
		queue_free()
