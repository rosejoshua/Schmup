extends CPUParticles2D
class_name ShipGib

func _ready():
	emitting = true

func _process(delta):
	if !emitting:
		queue_free()

