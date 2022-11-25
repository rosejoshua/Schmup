extends CPUParticles2D

func _ready():
	emitting = true
	var camera := get_tree().current_scene.find_node("Camera", true, false)
	camera.shake(10)

func _process(delta):
	if !emitting:
		queue_free()
