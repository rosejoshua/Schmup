extends Explosion

func _ready():
	var camera := get_tree().current_scene.find_node("Camera", true, false)
	camera.shake(10)
